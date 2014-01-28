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
  
  should "error for missing fields" do
    s = SectionModule.create({
      :text  => "Hello",
    })
        
    assert_equal s.valid?, false  
    assert_equal s.errors.messages[:type], ["can't be blank"]
    assert_equal s.errors.messages[:title], ["can't be blank"]
  end
  
  should "error for missing fields for text types" do
    s = SectionModule.create({
      :title => "This is a text module",
      :type  => "Text"
    })
    
    assert_equal s.valid?, false 
    assert_equal s.errors.messages[:link], ["can't be blank"]
    assert_equal s.errors.messages[:text], ["can't be blank"]
    assert_equal s.errors.messages[:colour], ["can't be blank"]
  end
  
  should "error for missing fields for frame types" do
    s = SectionModule.create({
      :title => "This is a frame module",
      :type  => "Frame"
    })
    
    assert_equal s.valid?, false 
    assert_equal s.errors.messages[:frame], ["can't be blank"]
  end
  
  should "error for missing fields for image types" do
    s = SectionModule.create({
      :title => "This is an image module",
      :type  => "Image"
    })
    
    assert_equal s.valid?, false 
    assert_equal s.errors.messages[:link], ["can't be blank"]
  end
  
  should "error if type is invalid" do
    s = SectionModule.create({
      :title => "This is an image module",
      :type  => "Foo"
    })
    
    assert_equal s.valid?, false
    assert_equal s.errors.messages[:type], ["is not included in the list"]
  end
  
end