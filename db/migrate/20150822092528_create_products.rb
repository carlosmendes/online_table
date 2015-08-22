class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :short_name
      t.decimal :price, :default => 0
      t.text :description
      t.integer :category_id
      t.integer :sub_category_id
      t.integer :order
      t.boolean :active, :default => true

      t.timestamps null: false
    end
  end
end
