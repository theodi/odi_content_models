require "edition"

class CourseEdition < Edition

  field :length,        type: String
  field :summary,       type: String
  field :outline,       type: String
  field :outcomes,      type: String
  field :audience,      type: String
  field :prerequisites, type: String
  field :requirements,  type: String
  field :materials,     type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:summary, 
                                                :outline, 
                                                :outcomes, 
                                                :audience, 
                                                :prerequisites, 
                                                :requirements, 
                                                :materials
                                                ]
  
  @fields_to_clone = [:length, :summary, :outline, :outcomes, :audience, :prerequisites, :requirements, :materials]

  def whole_body
    self.summary
  end
  
  def rendering_app
    "courses"
  end
  
end