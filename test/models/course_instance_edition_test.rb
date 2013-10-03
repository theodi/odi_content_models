require "test_helper"

class CourseInstanceEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    c = FactoryGirl.build(:course_instance_edition, panopticon_id: @artefact.id)
    c.description = "This is an awesome course_instance"

    c.safely.save!

    c = CourseInstanceEdition.first
    assert_equal "This is an awesome course_instance", c.description
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    course_instance = CourseInstanceEdition.new
    assert_equal "CourseInstance", course_instance.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      c = FactoryGirl.build(:course_instance_edition,
                            :panopticon_id => @artefact.id,
                            :description => "This is an awesome course_instance")
      expected = "This is an awesome course_instance"
      assert_equal expected, c.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    course_instance = FactoryGirl.create(:course_instance_edition,
                          :panopticon_id => @artefact.id,
                          :description => "This is an awesome course_instance",
                          :state => "published")
    new_course_instance = course_instance.build_clone

    assert_equal course_instance.description, new_course_instance.description

  end
  
end
