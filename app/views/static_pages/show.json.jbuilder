json.extract! @static_page, :id, :name, :description, :created_at, :updated_at
json.short_code @static_page.short_code
json.combined @static_page.combined