class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item

  validates_presence_of :status

  enum status: {
    packaged: 0,
    pending: 1,
    shipped: 2
  }

  def create
  end


  def find_discount
    item.merchant
    .discounts
    .where('threshold <= ?', quantity)
    .order(percentage: :desc)
    .first
  end

  def revenue
    (quantity * unit_price)
  end

  def discount_unit_price
     revenue * (1- find_discount.percentage.fdiv(100))
  end
end
