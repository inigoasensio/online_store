class Order < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :shipper
  has_many :purchases
  has_many :order_items

  # Attributes
  accepts_nested_attributes_for :order_items

  # Validations
  validates :order_date, :status, presence: true

  # Callbacks
  after_initialize :set_default_values

  # State Machine
  state_machine :status, initial: :in_progress do
    after_transition on: :saved_for_later, do: :saved
    after_transition on: :success, do: :purchase_cart_items!
    after_transition placed: :purchased, do: :purchase_cart_items!

    # Transitions
    event :add_to_cart do
      transition :in_progress => :placed
    end

    event :save_for_later do
      transition :placed => :saved_for_later
    end

    event :success do
      transition :placed => :purchased
    end

    event :ship do
      transition :purchased => :shipped
    end

    event :cancel do
      transition [:in_progress, :placed] => :cancelled
    end

    state :purchased do
      # purchase_cart_items!
    end
  end

  # Cart Methods
  def cart_total
    order_items.collect { |item| item.valid? ? item.total_price : 0 }.sum
  end

  def cart_count
    order_items.length
  end

  # Purchase Methods
  def purchase_cart_items!
    order_items.each { |order_item| purchase(order_item) }
    # success
  end

  def purchase(order_item)
    order_item.update_attributes(status: 'purchased')
    order_items.delete(order_item)
  end

  private

  def set_default_values
    self.order_date ||= Time.now
  end

  def saved

  end
end
