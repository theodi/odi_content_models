require "test_helper"

class EventEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    n = EventEdition.create(title: "Event Edition", panopticon_id: @artefact.id)
    n.start_date = 1.day.from_now
    n.end_date = 2.days.from_now
    n.location = "Shoreditch"
    n.description = "description"
    n.booking_url = "http://eventbrite.com/test"
    n.hashtag = "testing"
    
    n.safely.save!

    n = EventEdition.first
    assert_equal n.start_date.to_s, 1.day.from_now.to_datetime.to_s
    assert_equal n.end_date.to_s, 2.days.from_now.to_datetime.to_s
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
      n = EventEdition.create(:title => "Event Edition",
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
    event = EventEdition.create(:title => "Event Edition",
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

  context "generating paths" do

    should "creates /events/* paths for untagged items" do
      artefact = FactoryGirl.create(:artefact)
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/events/testing', n.rendering_path
    end

    should "creates /lunchtime-lectures/* paths for lectures" do
      FactoryGirl.create(:tag, :tag_id => "lunchtime-lecture", :tag_type => 'event', :title => "Lunchtime Lecture")
      artefact = FactoryGirl.create(:artefact, :event => ['lunchtime-lecture'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/lunchtime-lectures/testing', n.rendering_path
    end

    should "creates /meetups/* paths for meetups" do
      FactoryGirl.create(:tag, :tag_id => "meetup", :tag_type => 'event', :title => "Meetup")
      artefact = FactoryGirl.create(:artefact, :event => ['meetup'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/meetups/testing', n.rendering_path
    end

    should "creates /research-afternoons/* paths for research afternoons" do
      FactoryGirl.create(:tag, :tag_id => "research-afternoon", :tag_type => 'event', :title => "Research Afternoon")
      artefact = FactoryGirl.create(:artefact, :event => ['research-afternoon'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/research-afternoons/testing', n.rendering_path
    end
  
    should "creates /challenge-series/* paths for open data challenge events" do
      FactoryGirl.create(:tag, :tag_id => "open-data-challenge-series", :tag_type => 'event', :title => "Open Data Challenge Series")
      artefact = FactoryGirl.create(:artefact, :event => ['open-data-challenge-series'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/challenge-series/testing', n.rendering_path
    end

    should "creates /roundtables/* paths for roundtables" do
      FactoryGirl.create(:tag, :tag_id => "roundtable", :tag_type => 'event', :title => "Roundtable")
      artefact = FactoryGirl.create(:artefact, :event => ['roundtable'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/roundtables/testing', n.rendering_path
    end

    should "creates /workshops/* paths for workshops" do
      FactoryGirl.create(:tag, :tag_id => "workshop", :tag_type => 'event', :title => "Workshop")
      artefact = FactoryGirl.create(:artefact, :event => ['workshop'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/workshops/testing', n.rendering_path
    end

    should "creates /networking-events/* paths for networking events" do
      FactoryGirl.create(:tag, :tag_id => "networking-event", :tag_type => 'event', :title => "Networking Event")
      artefact = FactoryGirl.create(:artefact, :event => ['networking-event'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/networking-events/testing', n.rendering_path
    end

    should "creates /panel-discussions/* paths for panel discussions" do
      FactoryGirl.create(:tag, :tag_id => "panel-discussion", :tag_type => 'event', :title => "Panel Discussion")
      artefact = FactoryGirl.create(:artefact, :event => ['panel-discussion'])
      n = EventEdition.create(:title         => "Event", 
                              :panopticon_id => artefact.id,
                              :slug          => "testing")
      assert_equal '/panel-discussions/testing', n.rendering_path
    end

  end

end
