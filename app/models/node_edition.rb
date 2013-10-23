require "edition"
require 'attachable_with_metadata'

class NodeEdition < Edition
  include AttachableWithMetadata

  # name from artefact
  field :level,         type: Integer
  field :host,          type: String
  field :region,        type: String # ISO country code
  field :area,          type: String
  attaches_with_metadata :hero_image
  field :location,      type: Array, spacial: true, default: [0,0]
  field :description,   type: String
  field :url,           type: String
  # people are defined using PersonEdition#node
  field :telephone,     type: String
  field :email,         type: String
  field :twitter,       type: String
  field :linkedin,      type: String
  field :active,        type: Boolean, default: true
  
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [
    :level, :region, :area, :location, :description, :telephone, :email, :twitter, :linkedin, :host, :url, :active
  ]

  def whole_body
    description
  end

  def rendering_app
    "www"
  end
  
  def rendering_path
    "/nodes/#{slug}"
  end
  
  def latlng
    [location[0],location[1]].join(',')
  end
  
  def latlng=(latlng)
    ll = latlng.split(',')
    location[0] = ll[0].to_f
    location[1] = ll[1].to_f
  end

end
