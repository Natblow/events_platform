json.extract! attendee, :id, :email, :created_at, :updated_at
json.url attendee_url(attendee, format: :json)
