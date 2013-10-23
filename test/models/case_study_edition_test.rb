require "test_helper"

class CaseStudyEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    n = CaseStudyEdition.create(:title => "Case Study", :panopticon_id => @artefact.id)
    n.content                   = "Some long description here, blah, blah, blah"
    n.url                       = "http://bbc.co.uk"
    n.media_enquiries_name      = "Bob Fish"
    n.media_enquiries_email     = "bob@example.com"
    n.media_enquiries_telephone = "1234"

    n.safely.save!

    n = CaseStudyEdition.first
    assert_equal "Some long description here, blah, blah, blah", n.content
    assert_equal "http://bbc.co.uk", n.url
    assert_equal "Bob Fish", n.media_enquiries_name
    assert_equal "bob@example.com", n.media_enquiries_email
    assert_equal "1234", n.media_enquiries_telephone
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    case_study = CaseStudyEdition.new
    assert_equal "CaseStudy", case_study.format
  end
  
  context "whole_body" do
    should "contain just the content" do
      n = CaseStudyEdition.create(:title => "Case Study", 
                                  :panopticon_id => @artefact.id,
                                  :content => "Some long description here, blah, blah, blah")
      expected = "Some long description here, blah, blah, blah"
      assert_equal expected, n.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    case_study = CaseStudyEdition.create(:title => "Case Study", 
                                         :panopticon_id => @artefact.id,
                                         :content => "Some long description here, blah, blah, blah",
                                         :url => "http://bbc.co.uk",
                                         :media_enquiries_name => "Bob Fish",
                                         :media_enquiries_email => "bob@example.com",
                                         :media_enquiries_telephone => "1234",
                                         :state => "published")
    new_case_study = case_study.build_clone

    assert_equal case_study.content, new_case_study.content
    assert_equal case_study.url, new_case_study.url
    assert_equal case_study.media_enquiries_name, new_case_study.media_enquiries_name
    assert_equal case_study.media_enquiries_email, new_case_study.media_enquiries_email
    assert_equal case_study.media_enquiries_telephone, new_case_study.media_enquiries_telephone
  end

  context "generating paths" do

    should "creates /case-studies/* paths" do
      artefact = FactoryGirl.create(:artefact)
      n = CaseStudyEdition.create(:title         => "Case Study", 
                                  :panopticon_id => artefact.id,
                                  :slug          => "testing")
      assert_equal '/case-studies/testing', n.rendering_path
    end

  end

end
