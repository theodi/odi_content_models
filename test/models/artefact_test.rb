require "test_helper"

class ArtefactTest < ActiveSupport::TestCase
  
  should "allow an author to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", author: "luther-blisset")
    assert a.valid?
  end
  
  should "return an error if no tag is set for special types" do
    [:person, :timed_item, :asset, :article, :organization].each do |type|
      artefact = FactoryGirl.build(:artefact, kind: type)
      assert_equal false, artefact.valid?
    end
  end
    
end