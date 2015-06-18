json.array!(@registrations) do |registration|
  json.extract! registration, :id, :participant_id, :event_id
  json.url registration_url(registration, format: :json)
end
