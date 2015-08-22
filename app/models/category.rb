class Category < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  
  has_many :sub_categories
  has_many :products
  
end
