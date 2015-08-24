class OrderLine < ActiveRecord::Base
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :product
  belongs_to :order
  
  STATUS = ['Draft', 'Submitted', 'Processing', 'Delivered', 'Canceled']
  
  def self.status_draft
    OrderLine::STATUS[0]
  end

  def self.status_submitted
    OrderLine::STATUS[1]
  end

  def self.status_processing
    OrderLine::STATUS[2]
  end
  
  def self.status_delivered
    OrderLine::STATUS[3]
  end

  def self.status_canceled
    OrderLine::STATUS[4]
  end
    
  def self.get_pending
    OrderLine.includes(:product, :order => :table).where(:status => [OrderLine.status_submitted, OrderLine.status_processing]).order(:created_at)
  end
end
