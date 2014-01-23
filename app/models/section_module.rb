require "attachable"

class SectionModule
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include Attachable

  field :title,     type: String
  field :type,      type: String
  field :link,      type: String
  field :frame,     type: String
  field :text,      type: String
  field :colour,    type: String

  attaches :image
  
  def image_url
    image.try :image_url
  end
end
