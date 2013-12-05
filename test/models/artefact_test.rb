require "test_helper"

class ArtefactTest < ActiveSupport::TestCase
  
  should "allow an author to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", author: "luther-blisset")
    assert a.valid?
  end
  
  should "allows nodes to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", node: ["llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch", "westward-ho"])
    assert a.valid?
  end
  
  should "allows organizations to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", organization_name: ["wayne-enterprises", "arkham-asylum"])
    assert a.valid?
  end
  
  should "return an error if no tag is set for special types" do
    [:person, :timed_item, :asset, :article, :organization].each do |type|
      assert_raise Mongoid::Errors::Validations do 
        artefact = FactoryGirl.create(:artefact, kind: type)
      end
    end
  end
  
  should "return an error if no tag is set for special types with a role" do
    FactoryGirl.create(:tag, :tag_id => "odi", :tag_type => 'role', :title => "ODI")
    [:person, :timed_item, :asset, :article, :organization].each do |type|
      assert_raise Mongoid::Errors::Validations do 
        artefact = FactoryGirl.create(:artefact, kind: type, roles: ['odi'])
      end
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