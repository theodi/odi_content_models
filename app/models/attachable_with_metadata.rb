ATTACHMENT_METADATA_FIELDS = [
  :title,
  :source,
  :description,
  :creator,
  :attribution,
  :subject,
  :license,
  :spatial,
]

module AttachableWithMetadata 

  module ClassMethods
    
    def attaches_with_metadata(*fields)
      
      # Set up standard attachment
      attaches *fields
      
      # Add metadata methods
      fields.map(&:to_s).each do |attachment_field|        

        before_save :"update_#{attachment_field}_metadata", 
                    :if => :"#{attachment_field}_metadata_has_changed?"

        ATTACHMENT_METADATA_FIELDS.each do |metadata_field|
          
          field_name = "#{attachment_field}_#{metadata_field}"

          define_method(field_name) do
            if instance_variable_get("@#{field_name}").nil?
              instance_variable_set "@#{field_name}", send(attachment_field)[metadata_field.to_s]
            end
            case metadata_field
            when :spatial
              instance_variable_get("@#{field_name}").map{|x| x[1]}.join(',')
            when :subject
              instance_variable_get("@#{field_name}").join(',')
            else
              instance_variable_get("@#{field_name}")
            end
          end
          
          define_method("#{field_name}=") do |value|
            if instance_variable_get("@#{field_name}") != value
              instance_variable_set("@#{attachment_field}_metadata_has_changed", true)
              instance_variable_set("@#{field_name}", value)
            end
          end
          
        end
        
        define_method("#{attachment_field}_metadata_hash") do
          # Get all fields
          data = Hash[ATTACHMENT_METADATA_FIELDS.map do |metadata_field|
            [metadata_field, instance_variable_get("@#{attachment_field}_#{metadata_field}")]
          end]
          # Change non-string fields to their proper types
          data[:subject] = data[:subject] ? data[:subject].split(',') : []
          if data[:spatial]
            spatial = ['lat', 'lng'].zip(data[:spatial].split(','))
            data[:spatial] = Hash[spatial]
          end
          # Done
          data
        end

        define_method("#{attachment_field}_metadata_has_changed?") do
          instance_variable_get("@#{attachment_field}_metadata_has_changed") || false
        end
        
        define_method("update_#{attachment_field}_metadata") do
          raise ApiClientNotPresent unless Attachable.asset_api_client
          begin
            response = Attachable.asset_api_client.update_asset(send(:"#{attachment_field}_metadata_hash"))
            # Clear metadata tracking flag
            instance_variable_set("@#{attachment_field}_metadata_has_changed", false)
            # Explicit nil return so we don't return false form line above
            nil
          rescue StandardError
            errors.add("#{attachment_field}_id".to_sym, "could not be uploaded")
          end
        end
        
        define_method("upload_#{attachment_field}") do
          raise ApiClientNotPresent unless Attachable.asset_api_client
          begin
            data = {:file => instance_variable_get("@#{attachment_field}_file")}
            data.merge!(send(:"#{attachment_field}_metadata_hash")) if send(:"#{attachment_field}_metadata_has_changed?")
            response = Attachable.asset_api_client.create_asset(data)
            self.send("#{attachment_field}_id=", response.id.match(/\/([^\/]+)\z/) {|m| m[1] })
            # Clear metadata tracking flag
            instance_variable_set("@#{attachment_field}_metadata_has_changed", false)
            # Explicit nil return so we don't return false form line above
            nil
          rescue StandardError
            errors.add("#{attachment_field}_id".to_sym, "could not be uploaded")
          end
        end

      end
    end
    
  end
  
  def self.included(klass)
    klass.send(:include, Attachable)
    klass.extend ClassMethods
  end

end