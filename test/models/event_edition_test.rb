require "test_helper"

class EventEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    n = FactoryGirl.build(:event_edition, panopticon_id: @artefact.id)
    n.start_date = 1.hour.from_now
    n.end_date = 2.hours.from_now
    n.location = "Shoreditch"
    n.description = "description"
    n.booking_url = "http://eventbrite.com/test"
    n.hashtag = "testing"
    
    n.safely.save!

    n = EventEdition.first
    assert_equal n.start_date.to_s, 1.hour.from_now.to_s
    assert_equal n.end_date.to_s, 2.hours.from_now.to_s
    assert_equal n.location, "Shoreditch"
    assert_equal n.description, "description"
    assert_equal n.booking_url, "http://eventbrite.com/test"
    assert_equal n.hashtag, "testing"
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    event = EventEdition.new
    assert_equal "Event", event.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      n = FactoryGirl.build(:event_edition,
                            :panopticon_id => @artefact.id,
                            :start_date => 1.hour.from_now,
                            :end_date => 2.hours.from_now,
                            :location => "Shoreditch",
                            :description => "description",
                            :booking_url => "http://eventbrite.com/test",
                            :hashtag => "testing")
      expected = "description"
      assert_equal expected, n.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    event = FactoryGirl.create(:event_edition,
                          :panopticon_id => @artefact.id,
                          :start_date => 1.hour.from_now,
                          :end_date => 2.hours.from_now,
                          :location => "Shoreditch",
                          :description => "description",
                          :booking_url => "http://eventbrite.com/test",
                          :hashtag => "testing",
                          :state => "published")
    new_event = event.build_clone

    assert_equal event.start_date, new_event.start_date
    assert_equal event.end_date, new_event.end_date
    assert_equal event.location, new_event.location
    assert_equal event.description, new_event.description
    assert_equal event.booking_url, new_event.booking_url
    assert_equal event.hashtag, new_event.hashtag
  end

end
