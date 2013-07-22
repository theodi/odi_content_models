require "test_helper"

class CourseEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    c = FactoryGirl.build(:course_edition, panopticon_id: @artefact.id)
    c.length = "5 Days"
    c.summary = "This is an awesome course"
    c.outline = "Here is the course's outline y'all"
    c.outcomes = "This is what you will learn"
    c.audience = "You!"
    c.prerequisites = "A brain"
    c.requirements = "A pencil"
    c.materials = "Paper"

    c.safely.save!

    c = CourseEdition.first
    assert_equal "5 Days", c.length
    assert_equal "This is an awesome course", c.summary
    assert_equal "Here is the course's outline y'all", c.outline
    assert_equal "This is what you will learn", c.outcomes
    assert_equal "You!", c.audience
    assert_equal "A brain", c.prerequisites
    assert_equal "A pencil", c.requirements
    assert_equal "Paper", c.materials
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    course = CourseEdition.new
    assert_equal "Course", course.format
  end
  
  context "whole_body" do
    should "contain just the summary" do
      c = FactoryGirl.build(:course_edition,
                            :panopticon_id => @artefact.id,
                            :length => "5 Days",
                            :summary => "This is an awesome course",
                            :outline => "Here is the course's outline y'all",
                            :outcomes => "This is what you will learn",
                            :audience => "You!",
                            :prerequisites => "A brain",
                            :requirements => "A pencil",
                            :materials => "Paper")
      expected = "This is an awesome course"
      assert_equal expected, c.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    course = FactoryGirl.create(:course_edition,
                          :panopticon_id => @artefact.id,
                          :length => "5 Days",
                          :summary => "This is an awesome course",
                          :outline => "Here is the course's outline y'all",
                          :outcomes => "This is what you will learn",
                          :audience => "You!",
                          :prerequisites => "A brain",
                          :requirements => "A pencil",
                          :materials => "Paper",
                          :state => "published")
    new_course = course.build_clone

    assert_equal course.length, new_course.length
    assert_equal course.summary, new_course.summary
    assert_equal course.outline, new_course.outline
    assert_equal course.outcomes, new_course.outcomes
    assert_equal course.audience, new_course.audience
    assert_equal course.prerequisites, new_course.prerequisites
    assert_equal course.requirements, new_course.requirements
    assert_equal course.materials, new_course.materials

  end
  
end
