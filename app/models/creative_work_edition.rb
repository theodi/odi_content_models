require "edition"
require 'attachable_with_metadata'

class CreativeWorkEdition < Edition
  include AttachableWithMetadata

  # type (Collection / Media Asset) in tag
  # title uses artefact name field
  field :date_published, type: Date
  field :description,    type: String
  field :artist,         type: String
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [:date_published, :description, :artist]

  attaches :thumbnail
  attaches_with_metadata :file

  def whole_body
    description
  end

  def rendering_app
    "www"
  end

  def rendering_path
    "/culture/#{slug}"
  end

end
