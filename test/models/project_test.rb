require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = projects(:team_one_project_one)
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "name should not be empty" do
    @project.name = ""
    assert_not @project.valid?
  end

  test "name should not be blank" do
    @project.name = "    "
    assert_not @project.valid?
  end

  test "name length should not be more than 50" do
    @project.name = "a" * 51
    assert_not @project.valid?
  end

  test "description should allow nil" do
    @project.description = nil
    assert @project.valid?
  end

  test "description should allow empty" do
    @project.description = ""
    assert @project.valid?
  end

  test "description length should not be more than 140" do
    @project.description = "a" * 141
    assert_not @project.valid?
  end

  test "requirements should allow nil" do
    @project.requirements = nil
    assert @project.valid?
  end
  
  test "requirements should allow empty" do
    @project.requirements = ""
    assert @project.valid?
  end

  test "requirements length should not be more than 500" do
    @project.requirements = "a" * 501
    assert_not @project.valid?
  end
end
