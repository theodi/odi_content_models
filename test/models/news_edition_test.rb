require "test_helper"

class NewsEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    n = FactoryGirl.build(:news_edition, panopticon_id: @artefact.id)
    n.subtitle = "Foo bar Rubbish"
    n.body = "Some long description here, blah, blah, blah"
    n.featured = true

    n.safely.save!

    n = NewsEdition.first
    assert_equal "Foo bar Rubbish", n.subtitle
    assert_equal "Some long description here, blah, blah, blah", n.body
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
                          :featured => true,
                          :state => "published")
    new_news = news.build_clone

    assert_equal news.body, new_news.body
    assert_equal news.subtitle, new_news.subtitle
  end

end