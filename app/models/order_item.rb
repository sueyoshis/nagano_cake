class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end

end
