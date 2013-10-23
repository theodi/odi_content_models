require "edition"

class CourseInstanceEdition < Edition

  # this is interesting. Stubs need to be generated for this one, based on date - might not fit in standard way of doing things. Perhaps we need to learn from guides and steps in the govuk code?
  
  field :course,        type: String # references a course
  field :date,          type: DateTime
  field :location,      type: String
  field :price,         type: String
  field :description,   type: String
  field :url,           type: String
  field :trainers,      type: Array # need a way of selecting multiple people here

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]
  
  @fields_to_clone = [:course, :date, :location, :price, :description, :trainers, :url]

  def whole_body
    description
  end
  
  def rendering_app
    "www"
  end
  
  def rendering_path
    "/courses/#{course}/#{date.to_date.to_s}"
  end

end