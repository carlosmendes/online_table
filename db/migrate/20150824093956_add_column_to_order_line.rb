class AddColumnToOrderLine < ActiveRecord::Migration
  def change
    add_column :order_lines, :status, :string
    remove_column :order_lines, :delivered
  end
end
