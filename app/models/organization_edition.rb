require "edition"
require "attachable"

class OrganizationEdition < Edition
  include Attachable
  
  # type (Member / Start-up) : tag
  # name: artefact name
  field    :description,   type: String
  field    :joined_at,     type: Date
  attaches :logo
  field    :tagline,       type: String
  field    :involvement,   type: String
  field    :want_to_meet,  type: String
  field    :case_study,    type: String
  field    :url,           type: String
  field    :telephone,     type: String
  field    :email,         type: String
  field    :twitter,       type: String
  field    :linkedin,      type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [
    :description, :joined_at, :tagline, :involvement, :want_to_meet, 
    :case_study, :url, :telephone, :email, :twitter, :linkedin,
  ]
    
  def whole_body
    description
  end

  def rendering_app
    "www"
  end


end
