class HomeController < ApplicationController
  def index
    if current_user
    @friendsActivity = Array.new
    @latestActivity = Array.new
    latestOrders = current_user.orders.order(created_at: :desc).last("10")
    for order in latestOrders
      log= Hash.new
      if order.status != "Finished"
        for orderUser in order.order_users.order(created_at: :desc)
            if orderUser.user.email != current_user.try(:email) 
              log[:time] = orderUser.created_at
              log[:info] = "You send an invitation to " + orderUser.user.name + " to join your " + order.order_for + " from " + order.restaurant 
              log[:link] = false
              @latestActivity << log
              log= Hash.new
            end 
        end
        log[:time] = order.created_at
        log[:info] = order.order_for + " from " + order.restaurant + " on " + order.created_at.to_date.to_s 
        log[:link] = order_order_user_order_details_path(order.id,order.id)
      else
        log[:link] = false
        log[:time] = orderUser.created_at
        log[:info] = order.order_for + " from " + order.restaurant + " on " + order.created_at.to_date.to_s
      end
      @latestActivity << log
    end
    @latestActivity = @latestActivity.sort_by { |hsh| hsh[:time] }.reverse

    friendsOrders = current_user.friends
    for friend in friendsOrders
      for friendOrder in friend.orders.order(created_at: :desc)
        if Time.now.to_date - friendOrder.created_at.to_date < 5
          activity= Hash.new
          activity[:time] =friendOrder.created_at
          activity[:info]=friendOrder.user.name + " has created an order for " + friendOrder.order_for + " from " + friendOrder.restaurant + " at " + friendOrder.created_at.to_date.to_s
          @friendsActivity << activity
        end 
      end 
    end 
    @friendsActivity = @friendsActivity.sort_by { |hsh| hsh[:time] }.reverse
    end

  end

  def terms
  end

  def privacy
  end
end
