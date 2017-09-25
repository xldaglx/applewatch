json.extract! auction, :id, :user_id, :product_id, :amount, :created_at, :updated_at
json.url auction_url(auction, format: :json)
