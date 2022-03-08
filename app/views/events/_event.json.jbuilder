json.extract! event, :id, :address, :latitude, :longitude, :time, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
