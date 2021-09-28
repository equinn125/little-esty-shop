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

  def revenue
    quantity * unit_price
  end

  def find_discount
    item.merchant
    .discounts
    .where('threshold <= ?', quantity)
    .order(percentage: :desc)
    .first
  end

  def discount?
    find_discount != nil
  end

  def discount_price
      if discount?
     revenue * (1- find_discount.percentage.fdiv(100))
   else
     revenue
    end
  end
end
