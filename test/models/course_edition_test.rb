require "test_helper"

class CourseEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    c = CourseEdition.create(title: "Course Edition", panopticon_id: @artefact.id)
    c.length = "5 Days"
    c.description = "This is an awesome course"

    c.safely.save!

    c = CourseEdition.first
    assert_equal "5 Days", c.length
    assert_equal "This is an awesome course", c.description
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    course = CourseEdition.new
    assert_equal "Course", course.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      c = CourseEdition.create(:title => "Course Edition",
                               :panopticon_id => @artefact.id,
                               :length => "5 Days",
                               :description => "This is an awesome course",
                               ) 
      expected = "This is an awesome course"
      assert_equal expected, c.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    course = CourseEdition.create(:title => "Course Edition",
                                  :panopticon_id => @artefact.id,
                                  :length => "5 Days",
                                  :description => "This is an awesome course",
                                  :state => "published")
    new_course = course.build_clone

    assert_equal course.length, new_course.length
    assert_equal course.description, new_course.description

  end
  
  context "generating paths" do

    should "creates /courses/* paths" do
      artefact = FactoryGirl.create(:artefact)
      n = CourseEdition.create(:title         => "Course", 
                               :panopticon_id => artefact.id,
                               :slug          => "testing")
      assert_equal '/courses/testing', n.rendering_path
    end

  end

end
