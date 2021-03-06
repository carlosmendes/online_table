class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.integer :waiter_id
      t.integer :table_id
      t.decimal :total, :default => 0
      t.string :status

      t.timestamps null: false
    end
  end
end
