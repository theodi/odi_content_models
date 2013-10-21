require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @auth_hash = {
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
    Tag.create(title: "Team", tag_type: "person", tag_id: "writers")
  end
  
  test "should use an exisiting profile if one does exist" do
    artefact = FactoryGirl.create(:artefact)
    PersonEdition.create(title: "Luther Blisset", panopticon_id: artefact.id, slug: "luther-blisset")
    user = User.find_for_gds_oauth(@auth_hash).reload
    assert_equal "luther-blisset", user.profile
  end
  
  test "should create a profile if one doesn't exist" do
    assert_equal 0, PersonEdition.count
    user = User.find_for_gds_oauth(@auth_hash).reload
    artefact = Artefact.find_by_slug(user.profile)
    edition = Edition.where(panopticon_id: artefact._id).first
    assert_equal "luther-blisset", user.profile
    refute_nil artefact
    refute_nil edition
  end
  
end