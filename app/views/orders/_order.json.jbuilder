json.extract! order, :id, :restaurant, :order_for, :status, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
