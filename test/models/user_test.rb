require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    auth_hash = {
      "uid" => "1234abcd",
      "info" => {
        "uid"     => "1234abcd",
        "email"   => "user@example.com",
        "name"    => "Luther Blisset"
      },
      "extra" => {
        "user" => {
          "permissions" => ["signin"]
        }
      }
    }
    # Create a staff tag for testing purposes, ordinarily this would just exist
    Tag.create(title: "Staff", tag_type: "person", tag_id: "people/staff")
    @user = User.find_for_gds_oauth(auth_hash).reload
  end
  
  test "should have a profile assigned" do
    assert_equal "luther-blisset", @user.profile
  end
  
  test "should create a profile" do
    artefact = Artefact.find_by_slug(@user.profile)
    edition = Edition.where(panopticon_id: artefact._id).first
    refute_nil artefact
    refute_nil edition
  end
  
end