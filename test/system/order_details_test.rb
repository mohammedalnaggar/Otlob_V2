require "application_system_test_case"

class OrderDetailsTest < ApplicationSystemTestCase
  setup do
    @order_detail = order_details(:one)
  end

  test "visiting the index" do
    visit order_details_url
    assert_selector "h1", text: "Order Details"
  end

  test "creating a Order detail" do
    visit order_details_url
    click_on "New Order Detail"

    fill_in "Amount", with: @order_detail.amount
    fill_in "Comment", with: @order_detail.comment
    fill_in "Item", with: @order_detail.item
    fill_in "Order user", with: @order_detail.order_user_id
    fill_in "Price", with: @order_detail.price
    click_on "Create Order detail"

    assert_text "Order detail was successfully created"
    click_on "Back"
  end

  test "updating a Order detail" do
    visit order_details_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @order_detail.amount
    fill_in "Comment", with: @order_detail.comment
    fill_in "Item", with: @order_detail.item
    fill_in "Order user", with: @order_detail.order_user_id
    fill_in "Price", with: @order_detail.price
    click_on "Update Order detail"

    assert_text "Order detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Order detail" do
    visit order_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order detail was successfully destroyed"
  end
end
