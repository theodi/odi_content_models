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

  clone_fields :honorific_prefix, :honorific_suffix, :affiliation, :role, :description, :url,
               :telephone, :email, :twitter, :linkedin, :github, :node

  def whole_body
    description
  end

  def rendering_app
    "www"
  end

  def rendering_path
    tag_to_rendering_path "team" => "team",
                          "summit-speaker-2016" => "summit/2016/speakers"
  end


end
