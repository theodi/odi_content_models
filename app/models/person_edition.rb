require "edition"
require 'attachable'

class PersonEdition < Edition
  include Attachable

  # type (Staff / Trainer / Member / Start-up / Artist):  applied by tag
  field    :honorific_prefix, type: String
  field    :honorific_suffix, type: String
  field    :affiliation,      type: String
  # name: uses artefact name
  field    :role,             type: String
  field    :description,      type: String
  attaches :image
  field    :url,              type: String
  field    :telephone,        type: String
  field    :email,            type: String
  field    :twitter,          type: String
  field    :linkedin,         type: String
  field    :github,           type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [
    :honorific_prefix, :honorific_suffix, :affiliation, :role, :description, :url, 
    :telephone, :email, :twitter, :linkedin, :github, 
  ]
  
  def whole_body
    description
  end

  def rendering_app
    "people"
  end


end
