json.array!(@products) do |product|
  json.extract! product, :id, :name, :short_name, :price, :description, :category_id, :sub_category_id, :order, :active
  json.url product_url(product, format: :json)
end
