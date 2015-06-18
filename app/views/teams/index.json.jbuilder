json.array!(@teams) do |team|
  json.extract! team, :id, :tid, :team_name, :event_id
  json.url team_url(team, format: :json)
end
