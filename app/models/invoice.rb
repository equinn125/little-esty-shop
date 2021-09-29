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

  def total_merchant_revenue(merchant)
      invoice_items.joins(:item)
    .where('items.merchant_id =?', merchant)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.incomplete_invoices_ids_ordered
    joins(:invoice_items).where.not("invoice_items.status = ?", 2).select(:id, :created_at).order(:created_at).distinct(:id)
  end

  def total_revenue_invoice_items
    invoice_items.sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def merchant_invoice_items(merchant)
    invoice_items.joins(item: :merchant)
    .where('items.merchant_id = ?', merchant.id)
  end

  def total_merchant_revenue_discounted(merchant)
    merch_ii = merchant_invoice_items(merchant)
    merch_ii. sum do |ii|
      ii.discount_unit_price
    end
  end

  def total_revenue_discounted
    invoice_items.sum do |ii|
      ii.discount_unit_price
    end
  end
end
