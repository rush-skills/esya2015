json.extract! @event, :id, :name, :categories, :event_date_time, :team_size, :venue, :eligibilty, :registration_deadline, :photo, :created_at, :updated_at
json.combined raw @event.combined
json.info raw @event.info
json.short_code @event.short_code
json.description raw @event.description
json.rules raw @event.rules
json.judging raw @event.judging
json.prizes raw @event.prizes
json.contact raw @event.contact
if current_participant
  if @event.registered? current_participant
    json.registered "1"
    if current_participant.get_team(@event) != nil
      json.team_id current_participant.get_team(@event).tid
      json.current_team_size current_participant.get_team(@event).participants.count
    else
      json.team_id "0"
      json.current_team_size "1"
    end
  else
    json.registered "0"
    json.team_id "0"
    json.current_team_size "0"
  end
else
  json.registered "0"
  json.team_id "0"
  json.current_team_size "0"
end
json.team_event @event.team_event?
