class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Attributes
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Associations
  has_many :credit_cards
  has_many :payments, through: :credit_cards
  has_many :orders
  has_many :addresses, as: :addressable

  # Validations
  validates :email, :password, presence: true
  validates :password, confirmation: true
  # Image Validations
  has_attached_file :avatar
  validates_attachment :avatar, size: { in: 0..1.megabytes }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def cart_count
    get_cart_products.count
  end

  def get_cart_products
    cart_orders_id = OrderItem.pluck(:product_id)
    Product.find(cart_orders_id)
  end
end
