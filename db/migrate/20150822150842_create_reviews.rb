class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :order_id
      t.integer :rate
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
