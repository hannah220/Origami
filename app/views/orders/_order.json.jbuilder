json.extract! order, :id, :customer_id, :order_date, :ship_date, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
