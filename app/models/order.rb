class Order < ApplicationRecord
  belongs_to :user
  has_one_attached :menu
  has_many :order_users , dependent: :destroy
  has_many :users, through: :order_users
  enum status: [ :Waiting, :Finished]
  enum order_for: [ :Breakfast, :Launch, :Dinner]
end
