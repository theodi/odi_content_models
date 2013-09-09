require "edition"
require 'attachable_with_metadata'

class NewsEdition < Edition
  include AttachableWithMetadata

  field :subtitle,      type: String
  field :body,          type: String
  field :featured,      type: Boolean
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:body]

  @fields_to_clone = [:subtitle, :body]

  attaches_with_metadata :image

  attaches_with_metadata :video

  def whole_body
    body
  end

  def rendering_app
    "news"
  end

end
