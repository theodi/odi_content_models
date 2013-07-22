require "test_helper"

class NewsEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    n = FactoryGirl.build(:news_edition, panopticon_id: @artefact.id)
    n.subtitle = "Foo bar Rubbish"
    n.body = "Some long description here, blah, blah, blah"
    n.home_image = "http://i.imgur.com/HXPqs7I.gif"
    n.main_image = "http://i0.kym-cdn.com/photos/images/original/000/029/367/shipment-of-fail.jpg?1318992465"
    n.featured = true

    n.safely.save!

    n = NewsEdition.first
    assert_equal "Foo bar Rubbish", n.subtitle
    assert_equal "Some long description here, blah, blah, blah", n.body
    assert_equal "http://i.imgur.com/HXPqs7I.gif", n.home_image
    assert_equal "http://i0.kym-cdn.com/photos/images/original/000/029/367/shipment-of-fail.jpg?1318992465", n.main_image
    assert_equal true, n.featured
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    news = NewsEdition.new
    assert_equal "News", news.format
  end
  
  context "whole_body" do
    should "contain just the body" do
      n = FactoryGirl.build(:news_edition,
                            :panopticon_id => @artefact.id,
                            :subtitle => "Foo bar Rubbish",
                            :body => "Some long description here, blah, blah, blah",
                            :home_image =>  "http://i.imgur.com/HXPqs7I.gif",
                            :main_image => "http://i0.kym-cdn.com/photos/images/original/000/029/367/shipment-of-fail.jpg?1318992465",
                            :featured => true
                            )
      expected = "Some long description here, blah, blah, blah"
      assert_equal expected, n.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    news = FactoryGirl.create(:news_edition,
                          :panopticon_id => @artefact.id,
                          :subtitle => "Foo bar Rubbish",
                          :body => "Some long description here, blah, blah, blah",
                          :home_image =>  "http://i.imgur.com/HXPqs7I.gif",
                          :main_image => "http://i0.kym-cdn.com/photos/images/original/000/029/367/shipment-of-fail.jpg?1318992465",
                          :featured => true,
                          :state => "published")
    new_news = news.build_clone

    assert_equal news.body, new_news.body
    assert_equal news.subtitle, new_news.subtitle
    assert_equal news.home_image, new_news.home_image
    assert_equal news.main_image, new_news.main_image
  end

end