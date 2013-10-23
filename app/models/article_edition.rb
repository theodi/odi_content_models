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
    "www"
  end

  def rendering_path
    url_map = {
      "news"  => "news",
      "blog"  => "blog",
      "guide" => "guides",
    }
    section = artefact.tags.map{|x| url_map[x.tag_id]}.compact.join
    "#{'/' unless section.blank?}#{section}/#{slug}"
  end

end
