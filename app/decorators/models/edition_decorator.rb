class Edition

  def rendering_path
    "/#{slug}"
  end
  
  def self.clone_fields(*fields)
    @fields_to_clone ||= []
    @fields_to_clone += fields
  end

  def indexable_content
    if self.respond_to?(:whole_body)
      "#{Govspeak::Document.new(whole_body).to_text}".strip
    else
      title
    end
  end

  private
  
  def tag_to_rendering_path(url_map)
    section = artefact.tags.map{|x| url_map[x.tag_id]}.compact.join
    section = url_map[:default] if section.blank? && url_map[:default]
    "#{'/' unless section.blank?}#{section}/#{slug}"
  end

end