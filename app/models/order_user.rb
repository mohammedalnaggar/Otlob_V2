class OrderUser < ApplicationRecord
  belongs_to :order
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: [ :pending, :joined]
  
  after_commit :create_notifications, on: [:create]
  after_commit :remove_notifications, on: [:destroy]
  
  def create_notifications
    user = self.user
      if user != self.order.user
        Notification.create(notify_type: 'invitation',
          actor: self.order.user,
          user: user,
          target: user,
          second_target: self.order,
          msg: self.order.user.first_name + " has invited you to a " + self.order.order_for + " from " + self.order.restaurant
           )
      end
      for orderUser in self.order.users
        if orderUser != self.order.user and self.user != orderUser
          Notification.create(notify_type: 'notifyOrderUsers',
            actor: self.order.user,
            user: orderUser,
            target: self.user,
            second_target: self.order,
            msg: self.order.user.first_name + " has invited " + self.user.name + " to a " + self.order.order_for + " from " + self.order.restaurant 
          )
          end
      end
  end

  def remove_notifications
    Notification.create(notify_type: 'notifyOrderUsers',
            actor: self.order.user,
            user: user,
            target: user,
            second_target: self.order,
            msg: self.order.user.first_name + " has removed you from " + self.order.order_for + " from " + self.order.restaurant )
    for orderUser in self.order.users
        if orderUser != self.order.user and self.user != orderUser
          Notification.create(notify_type: 'notifyOrderUsers',
            actor: self.order.user,
            user: orderUser,
            target: self.user,
            second_target: self.order,
            msg: self.order.user.first_name + " has removed " + self.user.name + " from " + self.order.order_for + " from " + self.order.restaurant )
        end
      end
  end

end
