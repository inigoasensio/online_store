class Order < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :shipper
  has_many :payments
  has_one :order_detail

  # Attributes
  attr_accessible :order_date, :ship_date, :status

  # Validations
  validates :order_date, :ship_date, :sales_tax, :status, presence: true
end
