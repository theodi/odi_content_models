require "test_helper"

class ArtefactTest < ActiveSupport::TestCase
  
  should "allow an author to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", author: "luther-blisset")
    assert a.valid?
  end
  
  should "allow a node to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", node: "llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch")
    assert a.valid?
  end
  
  should "return an error if no tag is set for special types" do
    [:person, :timed_item, :asset, :article, :organization].each do |type|
      artefact = FactoryGirl.build(:artefact, kind: type)
      assert_equal false, artefact.valid?
    end
  end
   
  should "delegate rendering path to edition if possible" do
    FactoryGirl.create(:tag, :tag_id => "team", :tag_type => 'person', :title => "Team Member")
    FactoryGirl.create(:tag, :tag_id => "technical", :tag_type => 'team', :title => "Tech Team")
    artefact = FactoryGirl.create(:artefact, :person => ['team'], :team => ['technical'])
    n = PersonEdition.create(:title         => "Person", 
                             :panopticon_id => artefact.id,
                             :slug          => "testing")
    assert_equal '/team/testing', artefact.rendering_path                            
    assert_equal 'www', artefact.rendering_app
  end
   
  should "generate default rendering path if no editions available" do
    artefact = FactoryGirl.create(:artefact, slug: "batman", rendering_app: "gotham")
    assert_equal '/batman', artefact.rendering_path                            
    assert_equal 'gotham', artefact.rendering_app
  end

end