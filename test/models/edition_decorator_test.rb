require "test_helper"

class EditionDecoratorTest < ActiveSupport::TestCase
  context "with an Article Edition" do
    should "have indexable content" do
      tag = FactoryGirl.create(:tag, tag_type: "article", tag_id: "news")

      artefact = FactoryGirl.create(:artefact, 
        state: "live",
        kind: "article",
        owning_app: "publisher",
        article: ["news"])

      article = ArticleEdition.create(
        panopticon_id: artefact.id,
        title: "An awesome article",
        content: "All the stuff and things [thing](http://www.thething.com) with some markdown innit."
        )

      assert_equal "All the stuff and things thing with some markdown innit.", article.indexable_content
    end
  end
end