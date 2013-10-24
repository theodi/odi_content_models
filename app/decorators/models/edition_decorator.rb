class Edition

  def rendering_path
    "/#{slug}"
  end

  private
  
  def tag_to_rendering_path(url_map)
    section = artefact.tags.map{|x| url_map[x.tag_id]}.compact.join
    section = url_map[:default] if section.blank? && url_map[:default]
    "#{'/' unless section.blank?}#{section}/#{slug}"
  end

end