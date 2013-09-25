require "edition"

class ArticleEdition < Edition

  # type: (News Item / Blog Post / Media Release) uses tags
  # headline uses artefact name
  field :content,                   type: String
  field :url,                       type: String
  field :media_enquiries_name,      type: String
  field :media_enquiries_email,     type: String
  field :media_enquiries_telephone, type: String
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:content]

  @fields_to_clone = [:content, :url, :media_enquiries_name, :media_enquiries_email, :media_enquiries_telephone]

  def whole_body
    content
  end

  def rendering_app
    "news"
  end

end
