json.extract! order_user, :id, :status, :order_id, :user_id, :created_at, :updated_at
json.url order_user_url(order_user, format: :json)
