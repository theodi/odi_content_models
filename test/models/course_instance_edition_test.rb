require "test_helper"

class CourseInstanceEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    c = CourseInstanceEdition.create(title: "Course Instance Edition", panopticon_id: @artefact.id)
    c.description = "This is an awesome course_instance"
    c.to_date = "2013-01-01"

    c.safely.save!

    c = CourseInstanceEdition.first
    assert_equal "This is an awesome course_instance", c.description
    assert_equal "2013-01-01".to_date, c.to_date
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    course_instance = CourseInstanceEdition.new
    assert_equal "CourseInstance", course_instance.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      c =  CourseEdition.create(:title => "Course Instance Edition",
                                :panopticon_id => @artefact.id,
                                :description => "This is an awesome course_instance")
      expected = "This is an awesome course_instance"
      assert_equal expected, c.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    course_instance = CourseEdition.create(:title => "Course Instance Edition",
                                          :panopticon_id => @artefact.id,
                                          :description => "This is an awesome course_instance",
                                          :to_date => "2013-01-01",
                                          :state => "published")
    new_course_instance = course_instance.build_clone

    assert_equal course_instance.description, new_course_instance.description
    assert_equal course_instance.to_date, new_course_instance.to_date
  end
  
  context "generating paths" do

    should "creates /courses/{name}/{date} paths" do
      artefact = FactoryGirl.create(:artefact)
      n = CourseInstanceEdition.create(:title         => "Course Instance", 
                                       :panopticon_id => artefact.id,
                                       :slug          => "testing",
                                       :course        => 'course-name',
                                       :date          => Date.new(2012,11,15))
      assert_equal '/courses/course-name/2012-11-15', n.rendering_path
    end

  end

end
