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
        ATTACHMENT_METADATA_FIELDS.each do |metadata_field|
          
          define_method("#{attachment_field}_#{metadata_field}") do
            instance_variable_get("@#{attachment_field}_#{metadata_field}")
          end
          
          define_method("#{attachment_field}_#{metadata_field}=") do |value|
            instance_variable_set("@#{attachment_field}_#{metadata_field}", value)
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