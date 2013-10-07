require "test_helper"

class FaqEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact, kind: "faq")
  end
  
  should "have correct extra fields" do
    p = FaqEdition.create(title: "FAQ Edition", panopticon_id: @artefact.id)
    p.content = "description"
    
    p.safely.save!

    p = FaqEdition.first
    assert_equal p.content, "description"
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    faq = FaqEdition.new
    assert_equal "Faq", faq.format
  end
  
  context "whole_body" do
    should "contain just the content" do
      p = FaqEdition.create(:title => "FAQ Edition",
                            :panopticon_id => @artefact.id,
                            :content => "description")
      expected = "description"
      assert_equal expected, p.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    faq = FaqEdition.create(:title => "FAQ Edition",
                          :panopticon_id => @artefact.id,
                          :content => "description",
                          :state => "published")
    new_faq = faq.build_clone

    assert_equal faq.content, new_faq.content
  end
  
end