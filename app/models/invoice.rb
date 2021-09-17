class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def customer_full_name
    "#{customer.full_name}"
  end
  def total_revenue
    items.sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
