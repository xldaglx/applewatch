json.extract! user, :id, :email, :name, :middle, :created_at, :updated_at
json.url user_url(user, format: :json)
