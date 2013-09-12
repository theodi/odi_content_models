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
          
          # Work out the field name. For instance, 'image_description'
          field_name = "#{attachment_field}_#{metadata_field}"
          
          # Field 'get'
          # Loads from asset manager API if not set
          define_method(field_name) do
            if instance_variable_get("@#{field_name}").nil?
              instance_variable_set "@#{field_name}", send(attachment_field)[metadata_field.to_s]
            end
            instance_variable_get("@#{field_name}")
          end
          
          # Field 'set'
          # Sets up assignment methods for all fields
          # 'spatial' and 'subject' fields have special handling for assigning comma-separated
          # strings. Ideally this code should be higher up in a controller, but I couldn't
          # find the best place for it without digging into a whole load of new code.
          # Maybe later.
          case metadata_field
          when :spatial
            define_method("#{field_name}=") do |value|
              # Auto-parse string assignment - this would be better in a controller
              if value.is_a?(String)
                 spatial = ['lat', 'lng'].zip(value.split(','))
                 value = Hash[spatial]
              end
              # Store
              send("store_#{field_name}", value)
            end
          when :subject
            define_method("#{field_name}=") do |value|
              # Auto-parse string assignment - this would be better in a controller
              if value.is_a?(String)
                value = value.split(',')
              end
              # Store
              send("store_#{field_name}", value)
            end
          else
            define_method("#{field_name}=") do |value|
              send("store_#{field_name}", value)
            end
          end
          
          # Private store method, shared between all setters.
          define_method("store_#{field_name}") do |value|
            if instance_variable_get("@#{field_name}") != value
              # Update metadata change tracker
              instance_variable_set("@#{attachment_field}_metadata_has_changed", true)
              # Set instance var
              instance_variable_set("@#{field_name}", value)
            end
          end
          private "store_#{field_name}".to_sym
          
        end
        
        # Get all metadata fields as a single hash, for sending to the API calls
        define_method("#{attachment_field}_metadata_hash") do
          # Get all fields
          Hash[ATTACHMENT_METADATA_FIELDS.map do |metadata_field|
            [metadata_field, instance_variable_get("@#{attachment_field}_#{metadata_field}")]
          end]
        end

        # Get whether any metadata fields have changed
        define_method("#{attachment_field}_metadata_has_changed?") do
          instance_variable_get("@#{attachment_field}_metadata_has_changed") || false
        end
        
        # If we're updating an existing asset, write the metadata to the API
        define_method("update_#{attachment_field}_metadata") do
          raise ApiClientNotPresent unless Attachable.asset_api_client
          begin
            # Get the asset ID. Is in URL form, so we need to split it
            asset_id = send(attachment_field)['id'].split('/').last
            # Update data in asset manager API.
            response = Attachable.asset_api_client.update_asset(asset_id,
                         send(:"#{attachment_field}_metadata_hash"))
            # Clear metadata tracking flag
            instance_variable_set("@#{attachment_field}_metadata_has_changed", false)
            # Explicit nil return so we don't return false form line above
            nil
          rescue StandardError
            errors.add("#{attachment_field}_id".to_sym, "could not be uploaded")
          end
        end
        
        # Overloaded method from Attachable
        # We override the original, so that when we upload a new asset, we also
        # set metadata fields
        define_method("upload_#{attachment_field}") do
          raise ApiClientNotPresent unless Attachable.asset_api_client
          begin
            # Build data hash, with file object and metadata all together
            data = {:file => instance_variable_get("@#{attachment_field}_file")}
            data.merge!(send(:"#{attachment_field}_metadata_hash")) if send(:"#{attachment_field}_metadata_has_changed?")
            # Create asset in asset manager API
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