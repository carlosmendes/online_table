class Order < ActiveRecord::Base
  validates :status, presence: true
  
  belongs_to :table
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'
  belongs_to :waiter, class_name: 'User', foreign_key: 'waiter_id'
  
  has_many :order_lines

  accepts_nested_attributes_for :order_lines, :allow_destroy => true
  
  STATUS = ['Draft', 'Processing', 'Waiter Requested', 'Payment Requested', 'Paied', 'Canceled']
  
  def self.status_active
    [self.status_draft, self.status_processing, self.status_payment_requested, self.status_waiter_requested]
  end
  
  def self.status_draft
    Order::STATUS[0]
  end

  def self.status_processing
    Order::STATUS[1]
  end
  
  def self.status_waiter_requested
    Order::STATUS[2]
  end

  def self.status_payment_requested
    Order::STATUS[3]
  end
    
  def self.status_paied
    Order::STATUS[4]
  end

  def self.status_canceled
    Order::STATUS[5]
  end
end
