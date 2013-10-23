require "edition"
require "attachable_with_metadata"

class PersonEdition < Edition
  include AttachableWithMetadata

  # type (Staff / Trainer / Member / Start-up / Artist):  applied by tag
  field    :honorific_prefix, type: String
  field    :honorific_suffix, type: String
  field    :affiliation,      type: String
  # name: uses artefact name
  field    :role,             type: String
  field    :description,      type: String
  field    :url,              type: String
  field    :telephone,        type: String
  field    :email,            type: String
  field    :twitter,          type: String
  field    :linkedin,         type: String
  field    :github,           type: String
  field    :node,             type: String
  
  attaches_with_metadata :image

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [
    :honorific_prefix, :honorific_suffix, :affiliation, :role, :description, :url, 
    :telephone, :email, :twitter, :linkedin, :github, :node
  ]
  
  def whole_body
    description
  end

  def rendering_app
    "www"
  end
  
  def rendering_path
    url_map = {
      "team" => "team",
    }
    section = artefact.tags.map{|x| url_map[x.tag_id]}.compact.join
    "#{'/' unless section.blank?}#{section}/#{slug}"
  end
  

end
