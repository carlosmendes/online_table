json.array!(@order_lines) do |order_line|
  json.extract! order_line, :id, :order_id, :product_id, :quantity, :value, :delivered
  json.url order_line_url(order_line, format: :json)
end
