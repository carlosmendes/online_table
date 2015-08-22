class AddBooleansToUser < ActiveRecord::Migration
  def change
      add_column :users, :confirmed, :boolean, :default => false
      add_column :users, :active, :boolean, :default => true
      add_column :users, :receive_news, :boolean, :default => true
      add_column :users, :manager, :boolean, :default => false
      add_column :users, :waiter, :boolean, :default => false
  end
end
