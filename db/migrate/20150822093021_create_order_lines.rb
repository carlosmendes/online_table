class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.integer :order_id
      t.integer :product_id
      t.decimal :quantity, :default => 0
      t.decimal :value, :default => 0
      t.boolean :delivered, :default => false

      t.timestamps null: false
    end
  end
end
