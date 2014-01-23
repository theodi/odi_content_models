require "test_helper"

class SectionModuleTest < ActiveSupport::TestCase
  
  should "contain the correct fields" do
    s = SectionModule.create({
      :title  => "Hello",
      :type   => "Text",
      :link   => "http://www.example.com",
      :frame  => "news",
      :text   => "Hello there!",
      :colour => "1"
    })
    
    s.safely.save!
    
    assert_equal s.title, "Hello"
    assert_equal s.type, "Text"
    assert_equal s.link, "http://www.example.com"
    assert_equal s.frame, "news"
    assert_equal s.text, "Hello there!"
    assert_equal s.colour, "1"
  end
  
end