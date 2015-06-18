json.array!(@participant_teams) do |participant_team|
  json.extract! participant_team, :id, :team_id, :participant_id
  json.url participant_team_url(participant_team, format: :json)
end
