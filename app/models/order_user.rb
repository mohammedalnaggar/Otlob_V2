class OrderUser < ApplicationRecord
  belongs_to :order
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: [ :pending, :joined]
  
  after_commit :create_notifications, on: [:create]
  
  def create_notifications
    for user in self.order.users 
      if user != self.order.user
        Notification.create(notify_type: 'invitation',
          actor: self.order.user,
          user: user,
          target: user,
          second_target: self.order)
        end
      end
  end
end
