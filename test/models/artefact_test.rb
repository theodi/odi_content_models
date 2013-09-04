require "test_helper"

class ArtefactTest < ActiveSupport::TestCase
  
  should "allow an author to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", author: "luther-blisset")
    assert a.valid?
  end
    
end