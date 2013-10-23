require "test_helper"

class TimedItemEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    closing = 1.month.from_now.to_datetime
    item = TimedItemEdition.create(title: "Timed Item Edition", panopticon_id: @artefact.id)
    item.content = "Content goes here"
    item.end_date = closing

    item.safely.save!

    item = TimedItemEdition.first
    assert_equal "Content goes here", item.content
    assert_equal closing.to_s, item.end_date.to_s
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    item = TimedItemEdition.new
    assert_equal "TimedItem", item.format
  end
  
  context "whole_body" do
    should "contain just the content" do
      item = TimedItemEdition.create(:title => "Timed Item Edition",
                               :panopticon_id => @artefact.id,
                               :content => "Content here")
      expected = "Content here"
      assert_equal expected, item.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    item = TimedItemEdition.create(:title => "Timed Item Edition",
                          :panopticon_id => @artefact.id,
                          :content => "Clone me",
                          :end_date => Date.today,
                          :state => "published")
    new_item = item.build_clone
    assert_equal item.content, new_item.content
    assert_equal item.end_date.to_s, new_item.end_date.to_s
  end
  
  context "generating paths" do

    should "creates /* paths for untagged items" do
      artefact = FactoryGirl.create(:artefact)
      n = TimedItemEdition.create(:title         => "Timed Item", 
                                  :panopticon_id => artefact.id,
                                  :slug          => "testing")
      assert_equal '/testing', n.rendering_path
    end

    should "creates /consultation-responses/* paths for consultation responses" do
      FactoryGirl.create(:tag, :tag_id => "consultation-response", :tag_type => 'timed_item', :title => "Consultation Response")
      artefact = FactoryGirl.create(:artefact, :timed_item => ['consultation-response'])
      n = TimedItemEdition.create(:title         => "Timed Item", 
                                  :panopticon_id => artefact.id,
                                  :slug          => "testing")
      assert_equal '/consultation-responses/testing', n.rendering_path
    end

  end

end