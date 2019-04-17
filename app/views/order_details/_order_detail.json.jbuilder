json.extract! order_detail, :id, :item, :amount, :price, :comment, :order_user_id, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
