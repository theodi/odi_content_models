require "user"

class User
  field "profile", type: String  
  
  # If no profile is selected, create one
  after_create :create_profile
  
  protected
  
  # Create a draft profile for the user. This can then be edited at a later time
  def create_profile
    if self.profile.nil?
       a = Artefact.create(
                :name          => self.name.titleize, 
                :slug          => self.name.parameterize,
                :kind          => "Person", 
                :owning_app    => "publisher", 
                :tag_ids       => ["people"],
                :person        => ["writers"],
                :rendering_app => "frontend"
              )
       a.save
       
       edition = Edition.find_or_create_from_panopticon_data(a._id, self, nil)
       edition.save
       self.profile = a.slug
       self.save
    end
  end
end