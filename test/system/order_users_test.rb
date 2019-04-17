require "application_system_test_case"

class OrderUsersTest < ApplicationSystemTestCase
  setup do
    @order_user = order_users(:one)
  end

  test "visiting the index" do
    visit order_users_url
    assert_selector "h1", text: "Order Users"
  end

  test "creating a Order user" do
    visit order_users_url
    click_on "New Order User"

    fill_in "Order", with: @order_user.order_id
    fill_in "Status", with: @order_user.status
    fill_in "User", with: @order_user.user_id
    click_on "Create Order user"

    assert_text "Order user was successfully created"
    click_on "Back"
  end

  test "updating a Order user" do
    visit order_users_url
    click_on "Edit", match: :first

    fill_in "Order", with: @order_user.order_id
    fill_in "Status", with: @order_user.status
    fill_in "User", with: @order_user.user_id
    click_on "Update Order user"

    assert_text "Order user was successfully updated"
    click_on "Back"
  end

  test "destroying a Order user" do
    visit order_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order user was successfully destroyed"
  end
end
