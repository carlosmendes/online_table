class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.boolean :active, :default => true
      t.boolean :receive_news, :default => true
      t.boolean :manager, :default => false
      t.boolean :waiter, :default => false
      t.timestamps null: false
    end
  end
end
