require "edition"

class TimedItemEdition < Edition

  # type (Consultation Response / Procurement Item):  applied by tag
  # name: uses artefact name
  field    :content,          type: String
  # Status (open/closed): decided by whether closes_at is in the past, surely
  field    :closes_at,        type: DateTime

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:content]

  @fields_to_clone = [
    :content, :closes_at
  ]
  
  def whole_body
    content
  end

  def rendering_app
    "www"
  end


end
