require "edition"

class CourseEdition < Edition

  # course title uses name field
  field :length,        type: String
  field :description,   type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]
  
  @fields_to_clone = [:length, :description]

  def whole_body
    description
  end
  
  def rendering_app
    "www"
  end
  
  def rendering_path
    "/courses/#{slug}"
  end
  
end