json.extract! product, :id, :name, :description, :price, :price_correa, :qty, :created_at, :updated_at
json.url product_url(product, format: :json)
