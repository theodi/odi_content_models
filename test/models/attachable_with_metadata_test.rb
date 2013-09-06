require "test_helper"

class MockAssetApi
  class MockError < StandardError; end
end

class ModelWithAttachments
  include AttachableWithMetadata
  include Mongoid::Document

  attaches_with_metadata :image
end

class AttachableWithMetadataTest < ActiveSupport::TestCase
  setup do
    @edition = ModelWithAttachments.new
    Attachable.asset_api_client = MockAssetApi.new
  end
  
  should "have correct metadata fields for attachments" do
    @edition.image_creator = "Bob Fish"
    assert_equal "Bob Fish", @edition.image_creator
  end
  
  should "build combined metadata hash" do
    @edition.image_creator = "Bob Fish"
    @edition.image_title   = "Cats"
    assert_equal "Bob Fish", @edition.image_metadata_hash[:creator]
    assert_equal "Cats"    , @edition.image_metadata_hash[:title]
  end
  
  should "track metadata changes" do
    assert_equal false, @edition.image_metadata_has_changed?
    @edition.image_creator = "Bob Fish"
    assert_equal true, @edition.image_metadata_has_changed?
  end

  context "uploading changes" do

    should "should upload metadata changes when saving" do
      MockAssetApi.any_instance.expects(:update_asset).with({ 
        :title       => nil,
        :source      => nil,
        :description => nil,
        :creator     => "Bob Fish",
        :attribution => nil,
        :subject     => nil,
        :license     => nil,
        :spatial     => nil,
      })
      @edition.image_creator = "Bob Fish"
      @edition.save!
      # Now it's clean
      assert_equal false, @edition.image_metadata_has_changed?
    end

    should "create new assets if changed" do
      file = File.open(File.expand_path("../../fixtures/uploads/image.jpg", __FILE__))
      response = OpenStruct.new(:id => 'http://asset-manager.example.com/assets/an_image_id')
      MockAssetApi.any_instance.expects(:create_asset).with({ :file => file }).returns(response)
      # Change image
      @edition.image = file
      @edition.save!
    end
    
    should "create new assets if changed, with metadata" do
      file = File.open(File.expand_path("../../fixtures/uploads/image.jpg", __FILE__))
      response = OpenStruct.new(:id => 'http://asset-manager.example.com/assets/an_image_id')
      MockAssetApi.any_instance.expects(:create_asset).with({ 
        :file        => file,
        :title       => nil,
        :source      => nil,
        :description => nil,
        :creator     => "Bob Fish",
        :attribution => nil,
        :subject     => nil,
        :license     => nil,
        :spatial     => nil,
      }).returns(response)
      # Change image and metadata
      @edition.image = file
      @edition.image_creator = "Bob Fish"
      @edition.save!
      # Now it's clean
      assert_equal false, @edition.image_metadata_has_changed?
    end

  end

end