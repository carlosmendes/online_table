class Table < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 20 }
  validates :token, presence: true
  
  has_many :orders
end
