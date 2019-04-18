class OrderUser < ApplicationRecord
  belongs_to :order
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: [ :pinding, :joined]
  
  after_commit :create_notifications, on: [:create]
  
  def create_notifications
    for user in self.order.users 
      Notification.create(notify_type: 'invitation',
        actor: self.user,
        user: user,
        target: user,
        second_target: self.order)
      end
  end
end
