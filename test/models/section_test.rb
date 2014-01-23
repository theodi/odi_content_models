require "test_helper"

class SectionTest < ActiveSupport::TestCase
  setup do
    @modules = []
     5.times do |i|
       @s = SectionModule.create({
         :title  => "Hello #{i}",
         :type   => "Text #{i}",
         :link   => "http://www.example.com/#{i}",
         :frame  => "news #{i}",
         :text   => "Hello there! #{i}",
         :colour => "#{i}"
       })
       @modules << @s.id
     end
    
    @section = Section.create({
      :title => "This is a title",
      :link => "http://www.example.com",
      :alt => "Some alt test",
      :description => "Here it a description",
      :tag_id => "home",
      :modules => @modules
    })
  end
  
  should "have correct extra fields" do
    assert_equal "http://www.example.com", @section.link
    assert_equal "Some alt test", @section.alt
    assert_equal 5, @section.modules.count
    assert_equal @s.id.to_s, @section.modules.last.to_s
  end
  
  should "have inherit fields from Tag" do
    assert_equal "This is a title", @section.title
    assert_equal "home", @section.tag_id
  end
  
  should "assign default tag_type" do
    assert_equal "section", @section.tag_type
  end
  
  should "be queriable by tag_type" do
    section = Section.where(:tag_type => 'section')
    assert_equal 1, section.count
    assert_equal "This is a title", section.first.title
  end
  
  should "allow ordering of modules" do
    modules = [
        @section.modules[5],
        @section.modules[3],
        @section.modules[2],
        @section.modules[0],
        @section.modules[1],
        @section.modules[4]
      ]
      
    @section.modules = modules
    @section.save
    
    assert_equal @section.modules[0].to_s, @modules[5].to_s 
    assert_equal @section.modules[1].to_s, @modules[3].to_s 
    assert_equal @section.modules[2].to_s, @modules[2].to_s 
    assert_equal @section.modules[3].to_s, @modules[0].to_s 
    assert_equal @section.modules[4].to_s, @modules[1].to_s 
    assert_equal @section.modules[5].to_s, @modules[4].to_s 
  end
  
end