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

  should "allow live_at to be assigned" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", live_at: DateTime.now + 1.day)
    assert a.valid?
  end

  should "assign live_at to now by default" do
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day")
    a.save
    assert_equal a.live_at.to_date, a.created_at.to_date
  end

  should "allows featured tag to be assigned" do
    FactoryGirl.create(:tag, :tag_id => "featured", :tag_type => 'featured', :title => "featured")
    a = FactoryGirl.build(:artefact, slug: "its-a-nice-day", featured: ["featured"])
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

  should "apply the role correctly if no editions available" do
    FactoryGirl.create(:tag, :tag_id => "odi", :tag_type => 'role', :title => "ODI")
    artefact = FactoryGirl.create(:artefact, slug: "batman", rendering_app: "gotham", roles: ["odi"])
    assert_equal "ODI", artefact.roles.first.title
  end

  should "allow querying by role" do
    FactoryGirl.create(:tag, :tag_id => "odi", :tag_type => 'role', :title => "ODI")
    FactoryGirl.create(:artefact, name: "Batman", slug: "batman", rendering_app: "gotham", roles: ["odi"])
    artefact = Artefact.where(:slug => "batman", :tag_ids => "odi").first
    assert_equal "Batman", artefact.name
  end

  should "apply the role correctly for special types with a role" do
    FactoryGirl.create(:tag, :tag_id => "odi", :tag_type => 'role', :title => "ODI")
    FactoryGirl.create(:tag, :tag_id => "foo", :tag_type => 'role', :title => "Foo")
    FactoryGirl.create(:tag, :tag_id => "team", :tag_type => 'person', :title => "team")
    FactoryGirl.create(:tag, :tag_id => "procurement", :tag_type => 'timed_item', :title => "procurement")
    FactoryGirl.create(:tag, :tag_id => "thing", :tag_type => 'asset', :title => "thing")
    FactoryGirl.create(:tag, :tag_id => "page", :tag_type => 'article', :title => "page")
    FactoryGirl.create(:tag, :tag_id => "member", :tag_type => 'organization', :title => "member")
    {:timed_item => 'procurement', :article => 'page', :organization => 'member'}.each do |kind, tag|
      artefact = FactoryGirl.create(:artefact, :kind => kind, :roles => ['foo'], kind => [tag])
      assert_equal "Foo", artefact.roles.first.title
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
