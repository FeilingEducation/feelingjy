require 'test_helper'

class ConsultTransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get consult_transactions_index_url
    assert_response :success
  end

  test "should get new" do
    get consult_transactions_new_url
    assert_response :success
  end

  test "should get create" do
    get consult_transactions_create_url
    assert_response :success
  end

  test "should get show" do
    get consult_transactions_show_url
    assert_response :success
  end

  test "should get edit" do
    get consult_transactions_edit_url
    assert_response :success
  end

  test "should get update" do
    get consult_transactions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get consult_transactions_destroy_url
    assert_response :success
  end

end
