require "test_helper"

class PersonEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    p = FactoryGirl.build(:person_edition, panopticon_id: @artefact.id)
    p.biography = "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future."
    p.twitter = "example"
    p.email = "email@example.com"
    p.gravatar_email = "gravatar@example.com"

    p.safely.save!

    p = PersonEdition.first
    assert_equal "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future.", p.biography
    assert_equal "example", p.twitter
    assert_equal "email@example.com", p.email
    assert_equal "gravatar@example.com", p.gravatar_email
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    person = PersonEdition.new
    assert_equal "Person", person.format
  end
  
  context "whole_body" do
    should "contain just the biography" do
      p = FactoryGirl.build(:person_edition,
                            :panopticon_id => @artefact.id,
                            :biography => "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future.",
                            :twitter => "example",
                            :email => "email@example.com",
                            :gravatar_email => "gravatar@example.com")
      expected = "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future."
      assert_equal expected, p.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    person = FactoryGirl.create(:person_edition,
                          :panopticon_id => @artefact.id,
                          :biography => "Selfies direct trade fap, velit deep v street art salvia laborum banjo pour-over Godard mixtape keffiyeh literally tumblr. Next level Austin sapiente ugh, voluptate cred kogi ex fixie photo booth ullamco nostrud Odd Future.",
                          :twitter => "example",
                          :email => "email@example.com",
                          :gravatar_email => "gravatar@example.com",
                          :state => "published")
    new_person = person.build_clone

    assert_equal person.biography, new_person.biography
    assert_equal person.twitter, new_person.twitter
    assert_equal person.email, new_person.email
    assert_equal person.gravatar_email, new_person.gravatar_email
  end
  
end