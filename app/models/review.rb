class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :title, presence: true, length: { maximum: 75 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :product_id, presence: true
end
