json.array!(@participants) do |participant|
  json.extract! participant, :id, :name, :email, :phone, :college
  json.url participant_url(participant, format: :json)
end
