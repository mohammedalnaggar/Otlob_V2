require 'test_helper'

class OrderUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_user = order_users(:one)
  end

  test "should get index" do
    get order_users_url
    assert_response :success
  end

  test "should get new" do
    get new_order_user_url
    assert_response :success
  end

  test "should create order_user" do
    assert_difference('OrderUser.count') do
      post order_users_url, params: { order_user: { order_id: @order_user.order_id, status: @order_user.status, user_id: @order_user.user_id } }
    end

    assert_redirected_to order_user_url(OrderUser.last)
  end

  test "should show order_user" do
    get order_user_url(@order_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_user_url(@order_user)
    assert_response :success
  end

  test "should update order_user" do
    patch order_user_url(@order_user), params: { order_user: { order_id: @order_user.order_id, status: @order_user.status, user_id: @order_user.user_id } }
    assert_redirected_to order_user_url(@order_user)
  end

  test "should destroy order_user" do
    assert_difference('OrderUser.count', -1) do
      delete order_user_url(@order_user)
    end

    assert_redirected_to order_users_url
  end
end
