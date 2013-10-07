require "test_helper"

class OrganizationEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    p = OrganizationEdition.create(title: "Organization edition", panopticon_id: @artefact.id)
    p.description  = "description"
    p.joined_at    = Date.today
    p.tagline      = "tagline"
    p.involvement  = "involvment"
    p.want_to_meet = "want to meet"
    p.case_study   = "001-002-003"
    p.url          = "http://bbc.co.uk"
    p.telephone    = "1234"
    p.email        = "hello@example.com"
    p.twitter      = "example"
    p.linkedin     = "http://linkedin.com/example"
    
    p.safely.save!

    p = OrganizationEdition.first
    assert_equal p.description,  "description"
    assert_equal p.joined_at,  Date.today
    assert_equal p.tagline,  "tagline"
    assert_equal p.involvement,  "involvment"
    assert_equal p.want_to_meet,  "want to meet"
    assert_equal p.case_study,  "001-002-003"
    assert_equal p.url,  "http://bbc.co.uk"
    assert_equal p.telephone,  "1234"
    assert_equal p.email,  "hello@example.com"
    assert_equal p.twitter,  "example"
    assert_equal p.linkedin,  "http://linkedin.com/example"    
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    x = OrganizationEdition.new
    assert_equal "Organization", x.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      p = OrganizationEdition.create(:title => "Organization edition",
                                    :panopticon_id => @artefact.id,
                                    :description => "description")
      expected = "description"
      assert_equal expected, p.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    org = OrganizationEdition.create(:title => "Organization edition",
                          :panopticon_id => @artefact.id,
                          :description   => "description",
                          :joined_at     => Date.today,
                          :tagline       => "tagline",
                          :involvement   => "involvment",
                          :want_to_meet  => "want to meet",
                          :case_study    => "001-002-003",
                          :url           => "http://bbc.co.uk",
                          :telephone     => "1234",
                          :email         => "hello@example.com",
                          :twitter       => "example",
                          :linkedin      => "http://linkedin.com/example",
                          :state         => "published")
    new_org = org.build_clone

    assert_equal new_org.description, org.description
    assert_equal new_org.joined_at, org.joined_at
    assert_equal new_org.tagline, org.tagline
    assert_equal new_org.involvement, org.involvement
    assert_equal new_org.want_to_meet, org.want_to_meet
    assert_equal new_org.case_study, org.case_study
    assert_equal new_org.url, org.url
    assert_equal new_org.telephone, org.telephone
    assert_equal new_org.email, org.email
    assert_equal new_org.twitter, org.twitter
    assert_equal new_org.linkedin, org.linkedin
  end
  
end