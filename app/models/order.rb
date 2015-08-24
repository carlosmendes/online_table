class Order < ActiveRecord::Base
  validates :status, presence: true
  
  belongs_to :table
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'
  belongs_to :waiter, class_name: 'User', foreign_key: 'waiter_id'
  
  has_many :order_lines
  
  STATUS = ['Draft', 'Cooking', 'Paied']
  
  def self.status_draft
    Order::STATUS[0]
  end
  
end
