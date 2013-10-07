require "test_helper"

class NodeEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
    @level = 1
    @region = "GB"
    @location = [52.323434, -1.432443]
    @description = "Some long description here, blah, blah, blah"
    @telephone = "0121 1234 567"
    @email = "example@example.com"
    @twitter = "example"
    @linkedin = "http://www.linkedin.com/example"
  end
  
  should "have correct extra fields" do
    n = NodeEdition.create(title: "Node Edition", panopticon_id: @artefact.id)
    
    n.level = @level
    n.region = @region
    n.location = @location
    n.description = @description
    n.telephone = @telephone
    n.email = @email
    n.twitter = @twitter
    n.linkedin = @linkedin

    n.safely.save!

    n = NodeEdition.first

    assert_equal @level, n.level
    assert_equal @region, n.region
    assert_equal @location, n.location
    assert_equal @description, n.description
    assert_equal @telephone, n.telephone
    assert_equal @email, n.email
    assert_equal @twitter, n.twitter
    assert_equal @linkedin, n.linkedin
  end
  
  should "give a friendly (legacy supporting) description of its format" do
    node = NodeEdition.new
    assert_equal "Node", node.format
  end
  
  context "whole_body" do
    should "contain just the body" do
      n = NodeEdition.create(:title => "Node Edition",
                            :panopticon_id => @artefact.id,
                            :description => @description
                            )
      assert_equal @description, n.whole_body
    end
  end
  
  should "clone extra fields when cloning edition" do
    node = NodeEdition.create(:title => "Node Edition",
                          :panopticon_id => @artefact.id,
                          :level => @level,
                          :region => @region,
                          :location => @location,
                          :description => @description,
                          :telephone => @telephone,
                          :email => @email,
                          :twitter => @twitter,
                          :linkedin => @linkedin,
                          :state => "published")
    new_node = node.build_clone

    assert_equal node.level, new_node.level
    assert_equal node.region, new_node.region
    assert_equal node.location, new_node.location
    assert_equal node.description, new_node.description
    assert_equal node.telephone, new_node.telephone
    assert_equal node.email, new_node.email
    assert_equal node.twitter, new_node.twitter
    assert_equal node.linkedin, new_node.linkedin
  end

end