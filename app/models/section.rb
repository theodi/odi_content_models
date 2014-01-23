require "attachable"

class Section < Tag
  include Attachable
  
  field :link, type: String
  field :alt, type: String
  field :tag_type, type: String, default: "section"
  field :modules, type: Array, default: []
  
  attaches :hero_image
    
end