class OrderUser < ApplicationRecord
  belongs_to :order
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: [ :pinding, :joined]
end
