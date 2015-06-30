json.array!(@static_pages) do |static_page|
  json.extract! static_page, :id, :name, :short_code
  json.url static_page_url(static_page, format: :json)
end
