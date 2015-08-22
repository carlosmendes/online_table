json.array!(@categories) do |category|
  json.extract! category, :id, :name, :order, :active
  json.url category_url(category, format: :json)
end
