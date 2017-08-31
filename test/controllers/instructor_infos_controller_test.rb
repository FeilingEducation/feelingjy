require 'test_helper'

class InstructorInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get instructor_infos_new_url
    assert_response :success
  end

  test "should get create" do
    get instructor_infos_create_url
    assert_response :success
  end

  test "should get show" do
    get instructor_infos_show_url
    assert_response :success
  end

  test "should get edit" do
    get instructor_infos_edit_url
    assert_response :success
  end

  test "should get update" do
    get instructor_infos_update_url
    assert_response :success
  end

  test "should get destroy" do
    get instructor_infos_destroy_url
    assert_response :success
  end

end
