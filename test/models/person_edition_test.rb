require "test_helper"

class PersonEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end

  should "have correct extra fields" do
    p = PersonEdition.create(title: "Person Edition", panopticon_id: @artefact.id)
    p.description = "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future."
    p.twitter = "example"
    p.email = "email@example.com"
    p.node = "birmingham"

    p.safely.save!

    p = PersonEdition.first
    assert_equal "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future.", p.description
    assert_equal "example", p.twitter
    assert_equal "email@example.com", p.email
    assert_equal "birmingham", p.node
  end

  should "give a friendly (legacy supporting) description of its format" do
    person = PersonEdition.new
    assert_equal "Person", person.format
  end

  context "whole_body" do
    should "contain just the description" do
      p = PersonEdition.create(:title => "Person Edition",
                            :panopticon_id => @artefact.id,
                            :description => "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future.",
                            :twitter => "example",
                            :email => "email@example.com")
      expected = "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future."
      assert_equal expected, p.whole_body
    end
  end

  should "clone extra fields when cloning edition" do
    person = PersonEdition.create(:title => "Person Edition",
                          :panopticon_id => @artefact.id,
                          :description => "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future.",
                          :twitter => "example",
                          :email => "email@example.com",
                          :node => "birmingham",
                          :state => "published")
    new_person = person.build_clone

    assert_equal person.description, new_person.description
    assert_equal person.twitter, new_person.twitter
    assert_equal person.email, new_person.email
    assert_equal person.node, new_person.node
  end

  context "generating paths" do

    should "creates /* paths for untagged people" do
      artefact = FactoryGirl.create(:artefact)
      n = PersonEdition.create(:title         => "Person",
                               :panopticon_id => artefact.id,
                               :slug          => "testing")
      assert_equal '/testing', n.rendering_path
    end

    should "creates /team/* paths for team members" do
      FactoryGirl.create(:tag, :tag_id => "team", :tag_type => 'person', :title => "Team Member")
      FactoryGirl.create(:tag, :tag_id => "technical", :tag_type => 'team', :title => "Tech Team")
      artefact = FactoryGirl.create(:artefact, :person => ['team'], :team => ['technical'])
      n = PersonEdition.create(:title         => "Person",
                               :panopticon_id => artefact.id,
                               :slug          => "testing")
      assert_equal '/team/testing', n.rendering_path
    end

    should "create /summit/speakers for summit speakers" do
      FactoryGirl.create(:tag, :tag_id => "summit-speaker-2016", :tag_type => 'person', :title => "Summit speaker 2016")
      artefact = FactoryGirl.create(:artefact, :person => ['summit-speaker-2016'])
      n = PersonEdition.create(:title         => "Person",
                               :panopticon_id => artefact.id,
                               :slug          => "testing")
      assert_equal '/summit/2016/speakers/testing', n.rendering_path
    end

  end

end
