  if not order.nil?
	  json.extract! order, :id, :client_id, :waiter_id, :table_id, :total, :status, :created_at, :updated_at
	  json.client do
	  	json.extract! order.client, :id, :name
	  end
	  json.table do
	  	json.extract! order.table, :id, :name
	  end
	  json.url order_url(order, format: :json)
	  json.order_lines do
		json.array!(order.order_lines) do |order_line|
		  	json.extract! order_line, :id, :order_id, :product_id, :quantity, :value, :status
		  	json.url order_line_url(order_line, format: :json)
		  	json.product do
		  		json.extract! order_line.product, :id, :name
		  	end
		end
	  end
end