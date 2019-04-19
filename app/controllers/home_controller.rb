class HomeController < ApplicationController
  def index
    if current_user
    @latestOrders = current_user.orders.order(created_at: :desc).last("10")
    @friendsOrders = current_user.friends
    end

  end

  def terms
  end

  def privacy
  end
end
