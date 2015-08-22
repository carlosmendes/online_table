class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :order
      t.boolean :active, :default => true

      t.timestamps null: false
    end
  end
end
