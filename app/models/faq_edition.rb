require "edition"

class FaqEdition < Edition

  # title uses name field
  field :content,   type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:content]

  clone_fields :content

  def whole_body
    content
  end

  def rendering_app
    "www"
  end


end
