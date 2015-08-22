class Product < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :short_name, length: { maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :orders
  belongs_to :category
  belongs_to :sub_category
end
