json.array!(@events) do |event|
  json.extract! event, :id, :name, :category, :short_code
  json.url event_url(event, format: :json)
end
