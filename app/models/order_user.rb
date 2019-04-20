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
          second_target: self.order)
      end
      for orderUser in self.order.users
        if orderUser != self.order.user and self.user != orderUser
          Notification.create(notify_type: 'notifyOrderUsers',
            actor: self.order.user,
            user: orderUser,
            target: self.user,
            second_target: self.order)
        end
      end
  end

  def remove_notifications
    Notification.create(notify_type: 'removeOrderUser',
            actor: self.order.user,
            user: user,
            target: user,
            second_target: self.order)
    for orderUser in self.order.users
        if orderUser != self.order.user and self.user != orderUser
          Notification.create(notify_type: 'alertOrderUsers',
            actor: self.order.user,
            user: orderUser,
            target: self.user,
            second_target: self.order)
        end
      end
  end

end
