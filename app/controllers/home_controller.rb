class HomeController < ApplicationController
  def index
    if current_user
    @latestOrders = current_user.orders.last("10")
    end

  end

  def terms
  end

  def privacy
  end
end
