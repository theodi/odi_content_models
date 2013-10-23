require "edition"

class TimedItemEdition < Edition

  # type (Consultation Response / Procurement Item):  applied by tag
  # name: uses artefact name
  field    :content,          type: String
  # Status (open/closed): decided by whether end_date is in the past, surely
  field    :end_date,        type: DateTime

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:content]

  @fields_to_clone = [
    :content, :end_date
  ]
  
  def whole_body
    content
  end

  def rendering_app
    "www"
  end

  def rendering_path
    url_map = {
      "consultation-response" => "consultation-responses",
    }
    section = artefact.tags.map{|x| url_map[x.tag_id]}.compact.join
    "#{'/' unless section.blank?}#{section}/#{slug}"
  end
end
