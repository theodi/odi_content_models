require "edition"
require 'attachable_with_metadata'

class NodeEdition < Edition
  include AttachableWithMetadata

  # name from artefact
  field :level,         type: Integer
  field :region,        type: String # ISO country code
  attaches_with_metadata :hero_image
  field :location,      type: Array,  spacial: true
  field :description,   type: String
  # people are defined using PersonEdition#node
  field :telephone,     type: String
  field :email,         type: String
  field :twitter,       type: String
  field :linkedin,      type: String
  
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [
    :level, :region, :location, :description, :telephone, :email, :twitter, :linkedin
  ]

  def whole_body
    description
  end

  def rendering_app
    "www"
  end

end
