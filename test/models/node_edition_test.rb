require "test_helper"

class NodeEditionTest < ActiveSupport::TestCase
  setup do
    @artefact = FactoryGirl.create(:artefact)
    @level = 1
    @region = "GB"
    @host = "Some guys"
    @area = "Birmingham"
    @location = [52.323434, -1.432443]
    @url = "http://www.example.com"
    @description = "Some long description here, blah, blah, blah"
    @telephone = "0121 1234 567"
    @email = "example@example.com"
    @twitter = "example"
    @linkedin = "http://www.linkedin.com/example"
  end
  
  should "have correct extra fields" do
    n = NodeEdition.create(title: "Node Edition", panopticon_id: @artefact.id)
    
    n.level = @level
    n.host = @host
    n.region = @region
    n.area = @area
    n.location = @location
    n.url = @url
    n.description = @description
    n.telephone = @telephone
    n.email = @email
    n.twitter = @twitter
    n.linkedin = @linkedin

    n.safely.save!

    n = NodeEdition.first

    assert_equal @level, n.level
    assert_equal @region, n.region
    assert_equal @host, n.host
    assert_equal @area, n.area
    assert_equal @location, n.location
    assert_equal @url, n.url
    assert_equal @description, n.description
    assert_equal @telephone, n.telephone
    assert_equal @email, n.email
    assert_equal @twitter, n.twitter
    assert_equal @linkedin, n.linkedin
    assert_equal true, n.active
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
                          :host => @host,
                          :level => @level,
                          :region => @region,
                          :area => @area,
                          :location => @location,
                          :url => @url,
                          :description => @description,
                          :telephone => @telephone,
                          :email => @email,
                          :twitter => @twitter,
                          :linkedin => @linkedin,
                          :active => false,
                          :state => "published")
    new_node = node.build_clone

    assert_equal node.level, new_node.level
    assert_equal node.host, new_node.host
    assert_equal node.region, new_node.region
    assert_equal node.area, new_node.area
    assert_equal node.location, new_node.location
    assert_equal node.url, new_node.url
    assert_equal node.description, new_node.description
    assert_equal node.telephone, new_node.telephone
    assert_equal node.email, new_node.email
    assert_equal node.twitter, new_node.twitter
    assert_equal node.linkedin, new_node.linkedin
    assert_equal node.linkedin, new_node.linkedin
    assert_equal false, new_node.active
  end

  context "generating paths" do

    should "creates /nodes/* paths" do
      artefact = FactoryGirl.create(:artefact)
      n = NodeEdition.create(:title         => "Node", 
                             :panopticon_id => artefact.id,
                             :slug          => "testing")
      assert_equal '/nodes/testing', n.rendering_path
    end

  end

end