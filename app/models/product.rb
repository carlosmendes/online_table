class Product < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :short_name, length: { maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :orders
  belongs_to :category
  belongs_to :sub_category
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image,
    content_type: { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png", 'image/pjpeg'] },
    size: { in: 0..10.megabytes }
end
