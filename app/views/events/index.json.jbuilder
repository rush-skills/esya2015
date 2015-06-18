json.array!(@events) do |event|
  json.extract! event, :id, :name, :type, :rules, :judging, :event_date_time, :team_size, :venue, :eligibilty, :registration_deadline, :prizes, :contact, :photo
  json.url event_url(event, format: :json)
end
