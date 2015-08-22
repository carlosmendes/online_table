class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.integer :category_id
      t.integer :order
      t.boolean :active, :default => true

      t.timestamps null: false
    end
  end
end
