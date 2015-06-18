json.array!(@event_admins) do |event_admin|
  json.extract! event_admin, :id, :event_id, :user_id
  json.url event_admin_url(event_admin, format: :json)
end
