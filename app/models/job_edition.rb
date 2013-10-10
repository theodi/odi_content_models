require "edition"

class JobEdition < Edition

  # job title uses name field
  field :location,      type: String
  field :salary,        type: String
  field :description,   type: String
  field :closing_date,  type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [:location, :salary, :description, :closing_date]

  def whole_body
    description
  end

  def rendering_app
    "www"
  end


end