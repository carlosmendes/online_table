class OrderLine < ActiveRecord::Base
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :product
  belongs_to :order
end
