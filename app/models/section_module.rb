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
  
  validates_inclusion_of :type, in: ['Image', 'Frame', 'Text'], allow_nil: true
  
  validates_presence_of :title, :type
  validates_presence_of :link, if: '["Image", "Text"].include?(type)'
  validates_presence_of :frame, if: 'type == "Frame"'
  validates_presence_of :text, :colour, if: 'type == "Text"'
  
  attaches :image
  
  def image_url
    image.try :image_url
  end
end
