class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :payment_method, presence: true
  validates :postage, presence: true
  validates :billing_amount, presence: true, numericality: { greater_than: 0 }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_paymant: 0, payment_confirmation: 1, production: 2, ready_to_ship: 3, sent: 4}

  def total_price
    total_price = 0
    order_items.each do |order_item|
      total_price += order_item.subtotal
    end
    total_price
  end

  def total_amount
    total_amount = 0
    order_items.each do |order_item|
      total_amount += order_item.amount
    end
    total_amount
  end

end
