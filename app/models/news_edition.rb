require "edition"

class NewsEdition < Edition
  include Attachable

  field :subtitle,      type: String
  field :body,          type: String
  field :featured,      type: Boolean
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:body]

  @fields_to_clone = [:subtitle, :body, :home_image, :main_image]

  attaches :image

  def whole_body
    body
  end

  def rendering_app
    "news"
  end

end
