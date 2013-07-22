require "edition"

class NewsEdition < Edition

  field :subtitle,      type: String
  field :body,          type: String
  field :home_image,    type: String
  field :main_image,    type: String
  field :featured,      type: Boolean
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:body]

  @fields_to_clone = [:subtitle, :body, :home_image, :main_image]

  def whole_body
    body
  end
end
