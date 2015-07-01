json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :name, :category, :image
  json.url sponsor_url(sponsor, format: :json)
end
