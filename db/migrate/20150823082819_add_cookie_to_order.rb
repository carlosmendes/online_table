class AddCookieToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :session_cookie, :string
  end
end
