require "test_helper"

class ArticleEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do    
    n = ArticleEdition.create(:title => "Article", :panopticon_id => @artefact.id)
    n.content                   = "Some long description here, blah, blah, blah"
    n.url                       = "http://bbc.co.uk"
    n.media_enquiries_name      = "Bob Fish"
    n.media_enquiries_email     = "bob@example.com"
    n.media_enquiries_telephone = "1234"

    n.safely.save!

    n = ArticleEdition.first
    assert_equal "Some long description here, blah, blah, blah", n.content
    assert_equal "http://bbc.co.uk", n.url
    assert_equal "Bob Fish", n.media_enquiries_name
    assert_equal "bob@example.com", n.media_enquiries_email
    assert_equal "1234", n.media_enquiries_telephone
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    article = ArticleEdition.new
    assert_equal "Article", article.format
  end
  
  context "whole_body" do
    should "contain just the content" do
      n = ArticleEdition.create(:title => "Article", 
                                :panopticon_id => @artefact.id,
                                :content => "Some long description here, blah, blah, blah")
      expected = "Some long description here, blah, blah, blah"
      assert_equal expected, n.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    article = ArticleEdition.create(:title => "Article",
                          :panopticon_id => @artefact.id,
                          :content => "Some long description here, blah, blah, blah",
                          :url => "http://bbc.co.uk",
                          :media_enquiries_name => "Bob Fish",
                          :media_enquiries_email => "bob@example.com",
                          :media_enquiries_telephone => "1234",
                          :state => "published")
    new_article = article.build_clone

    assert_equal article.content, new_article.content
    assert_equal article.url, new_article.url
    assert_equal article.media_enquiries_name, new_article.media_enquiries_name
    assert_equal article.media_enquiries_email, new_article.media_enquiries_email
    assert_equal article.media_enquiries_telephone, new_article.media_enquiries_telephone
  end

end