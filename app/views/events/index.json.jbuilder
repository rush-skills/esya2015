json.array!(@events) do |event|
  json.extract! event, :id, :name, :short_code, :photo
  json.url event_url(event, format: :json)
  json.categories event.categories
end
