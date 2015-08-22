class SubCategory < ActiveRecord::Base
  validates :name, presence: true , length: { maximum: 50 }
  validates :category_id, presence: true
  
  has_many :products
  belongs_to :category
end
