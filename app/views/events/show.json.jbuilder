json.extract! @event, :id, :name, :category, :event_date_time, :team_size, :venue, :eligibilty, :registration_deadline, :photo, :created_at, :updated_at
json.rules raw @event.rules
json.judging raw @event.judging
json.prizes raw @event.prizes
json.contact raw @event.contact