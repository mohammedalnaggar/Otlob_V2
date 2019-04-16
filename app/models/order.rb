class Order < ApplicationRecord
  belongs_to :user
  has_one_attached :menu
  enum status: [ :waiting, :finished]
  enum order_for: [ :Breakfast, :Launch, :Dinner]
end
