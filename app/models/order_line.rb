class OrderLine < ActiveRecord::Base
  validates :product_id, presence: true
  #validates :order_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :product
  belongs_to :order
  
  after_save :update_total
  after_destroy :update_total
  
  STATUS = ['Draft', 'Requested', 'Processing', 'Delivered', 'Canceled']

  def update_total
    self.order.total = OrderLine.where(:order_id => self.order_id).where('order_lines.status != ?',OrderLine.status_canceled).sum(:value)  
    self.order.save
  end
  
  def self.status_draft
    OrderLine::STATUS[0]
  end

  def self.status_requested
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
    OrderLine.joins(:product, :order => :table)
      .where(:status => [OrderLine.status_requested, OrderLine.status_processing])
      .where('orders.status IN (?)',Order.status_active)
      .order(:created_at)
  end
end
