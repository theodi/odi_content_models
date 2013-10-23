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
    tag_to_rendering_path "consultation-response" => "consultation-responses"
  end
  
end
