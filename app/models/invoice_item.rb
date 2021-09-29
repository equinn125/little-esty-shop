class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants

  validates_presence_of :status

  enum status: {
    packaged: 0,
    pending: 1,
    shipped: 2
  }

  def create
  end


  def find_discount
    discounts
    .where('threshold <= ?', quantity)
    .order(percentage: :desc)
    .first
  end


  def revenue
    (quantity * unit_price)
  end

  def discount_unit_price
    if find_discount != nil
     revenue * (1- find_discount.percentage.fdiv(100))
   else
     revenue
   end
  end
end
