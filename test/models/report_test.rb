require "test_helper"

class PersonEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
  end
  
  should "have correct extra fields" do
    r = ReportEdition.create(title: "Report Edition", panopticon_id: @artefact.id)
    r.date = "2014-02-01"

    r.safely.save!

    r = ReportEdition.first
    assert_equal DateTime.parse("2014-02-01"), r.date
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    report = ReportEdition.new
    assert_equal "Report", report.format
  end
  
  should "clone extra fields when cloning edition" do
    report = ReportEdition.create(:title => "Report Edition",
                          :panopticon_id => @artefact.id,
                          :date => "2014-02-01",
                          :state => "published"
                          )
    new_report = report.build_clone

    assert_equal new_report.date, report.date
  end
  
  should "create correct paths" do
    artefact = FactoryGirl.create(:artefact)
    r = ReportEdition.create(:title         => "Report", 
                             :panopticon_id => @artefact.id,
                             :slug          => "testing")
    assert_equal '/reports/testing', r.rendering_path
  end
end