require "test_helper"

class CreativeWorkEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    n =  CreativeWorkEdition.create(title: "Creative Work Edition", panopticon_id: @artefact.id)
    n.description = "Some long description here, blah, blah, blah"
    n.date_published = Date.today

    n.safely.save!

    n = CreativeWorkEdition.first
    assert_equal "Some long description here, blah, blah, blah", n.description
    assert_equal Date.today, n.date_published
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    creative_work = CreativeWorkEdition.new
    assert_equal "CreativeWork", creative_work.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      n = CreativeWorkEdition.create(:title => "Creative Work Edition",
                                    :panopticon_id => @artefact.id,
                                    :description => "Some long description here, blah, blah, blah",
                                    :date_published => Date.today
                                    )
      expected = "Some long description here, blah, blah, blah"
      assert_equal expected, n.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    creative_work = CreativeWorkEdition.create(:title => "Creative Work Edition",
                                              :panopticon_id => @artefact.id,
                                              :description => "Some long description here, blah, blah, blah",
                                              :date_published => Date.today,
                                              :state => "published")
    new_creative_work = creative_work.build_clone

    assert_equal creative_work.description, new_creative_work.description
    assert_equal creative_work.date_published, new_creative_work.date_published
  end

end