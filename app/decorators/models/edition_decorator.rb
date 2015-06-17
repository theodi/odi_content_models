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
    section = artefact.tags.map{|x| url_map[x.tag_id]}.compact.uniq.join
    section = url_map[:default] if section.blank? && url_map[:default]
    "#{'/' unless section.blank?}#{section}/#{slug}"
  end

  def update_from_artefact(artefact)
    ####################################################################
    # Removing the update to title. This action is triggered when there
    # is an update to the artefact in Panopticon. Agreed with @pezolio
    # on 17 June to comment out, in case VERY BAD THINGS happen.
    # slug is the prime linkage, but think that section, department and
    # business_proposition are mastered in Panopticon / artefact, so
    # should maintain them there, and ensure that existing editions are
    # updated.
    # The issue is here: https://github.com/theodi/publisher/issues/135
    #

    # self.title = artefact.name unless published?
    self.slug = artefact.slug
    self.section = artefact.section
    self.department = artefact.department
    self.business_proposition = artefact.business_proposition
    self.save!
  end

end
