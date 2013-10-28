require "attachable_with_metadata"

class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps

  include AttachableWithMetadata

  attaches_with_metadata :file

  def file_url
    file.try :file_url
  end
end
