json.extract! @participant, :id, :name, :email, :phone, :college, :created_at, :updated_at
json.complete @participant.profile_complete?
json.login true