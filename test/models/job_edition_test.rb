require "test_helper"

class JobEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    p = JobEdition.create(title: "Job edition", panopticon_id: @artefact.id)
    p.location = "The Moon"
    p.salary = "20p/decade"
    p.description = "description"
    p.closing_date = "2013-01-02"
    
    p.safely.save!

    p = JobEdition.first
    assert_equal p.location, "The Moon"
    assert_equal p.salary, "20p/decade"
    assert_equal p.description, "description"
    assert_equal p.closing_date.to_s, "2013-01-02"
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    job = JobEdition.new
    assert_equal "Job", job.format
  end
  
  context "whole_body" do
    should "contain just the description" do
      p = JobEdition.create(:title => "Job edition",
                            :panopticon_id => @artefact.id,
                            :location => "The Moon",
                            :salary => "20p/decade",
                            :description => "description",
                            :closing_date => 1.month.from_now)
      expected = "description"
      assert_equal expected, p.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    job = JobEdition.create(:title => "Job edition",
                          :panopticon_id => @artefact.id,
                          :location => "The Moon",
                          :salary => "20p/decade",
                          :description => "description",
                          :closing_date => 1.month.from_now,
                          :state => "published")
    new_job = job.build_clone

    assert_equal job.location, new_job.location
    assert_equal job.salary, new_job.salary
    assert_equal job.description, new_job.description
    assert_equal job.closing_date, new_job.closing_date
  end
  
end