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
    "#{customer.first_name} #{customer.last_name}"
  end

  def self.incomplete_invoices
    
  end
end
