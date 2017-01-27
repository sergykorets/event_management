json.extract! event, :id, :time, :place, :purpose, :created_at, :updated_at
json.url event_url(event, format: :json)