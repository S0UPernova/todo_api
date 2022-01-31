require "test_helper"

class TeamTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @wrong_user = users(:archer)
    @team = teams(:team_one)
  end

  test "should be valid" do
    assert @team.valid?
  end

  test "name should be present" do
    @team.name = "    "
    assert_not @team.valid?
  end

  test "name should not be too long" do
    @team.name = "a" * 51
    assert_not @team.valid?
  end

  test "team names should be unique" do
    duplicate_team = @team.dup
    @team.save
    assert_not duplicate_team.valid?
  end

  test "description should be present" do
    @team.description = "    "
    assert_not @team.valid?
  end

  test "description should not be too long" do
    @team.description = "a" * 141
    assert_not @team.valid?
  end

  test "team descriptions should be unique" do
    duplicate_team = @team.dup
    @team.save
    assert_not duplicate_team.valid?
  end
end
