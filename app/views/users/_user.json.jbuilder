json.extract! user, :id, :name, :email, :encrypted_password, :reset_password_token,
 :reset_password_sent_at, :remember_created_at, :created_at, :updated_at, :admin
json.url user_url(user, format: :json)
