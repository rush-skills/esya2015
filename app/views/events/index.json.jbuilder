json.array!(@events) do |event|
  json.extract! event, :id, :name, :short_code, :photo, :updated_at
  json.url event_url(event, format: :json)
  json.categories event.categories

  if current_participant
    if event.registered? current_participant
      json.registered "1"
      if current_participant.get_team(event) != nil
        json.team_id current_participant.get_team(event).tid
      else
        json.team_id "0"
      end
    else
      json.registered "0"
      json.team_id "0"
    end
  else
    json.registered "0"
    json.team_id "0"
  end
end
