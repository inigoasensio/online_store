class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Attributes
  attr_accessible :first_name, :last_name, :phone, :email, :password, :password_confirmation, :remember_me

  # Associations
  has_many :credit_cards
  has_many :purchases
  has_many :orders, through: :purchases
  has_many :addresses, as: :addressable

  # Validations
  validates :email, :password, presence: true
  validates :password, confirmation: true
  # Image Validations
  has_attached_file :avatar
  validates_attachment :avatar, size: { in: 0..1.megabytes }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def has_payment_info?
    braintree_customer_id
  end
end
