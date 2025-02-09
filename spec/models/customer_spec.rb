require 'rails_helper'

RSpec.describe Customer do
  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end

  it 'can return the customers first and last name together' do
    customer_1 = Customer.create!(first_name: 'Bob', last_name: 'Johnson')
    expect(customer_1.full_name).to eq('Bob Johnson')
  end

  it 'returns the top 5 customers' do
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @customer_2 = Customer.create(first_name: 'Sally', last_name: 'Johnson')
    @customer_3 = Customer.create(first_name: 'Bill', last_name: 'Smith')
    @customer_4 = Customer.create(first_name: 'Sara', last_name: 'Smith')
    @customer_5 = Customer.create(first_name: 'Santa', last_name: 'Claus')
    @customer_6 = Customer.create(first_name: 'Barry', last_name: 'Jones')
    @merchant_1 = Merchant.create!(name: "Cool Shirts")
    @merchant_2 = Merchant.create!(name: "Ugly Shirts")
    @merchant_3 = Merchant.create!(name: "Rad Shirts")
    @merchant_4 = Merchant.create!(name: "Bad Shirts")
    @merchant_5 = Merchant.create!(name: "Khoi's Shirts")
    @merchant_6 = Merchant.create!(name: "Kelsey's Shirts")
    @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_3.id)
    @item_4 = Item.create!(name: "shirt with kitten", description: "super cool shirt", unit_price: 700, merchant_id: @merchant_4.id)
    @item_5 = Item.create!(name: "black shirt", description: "super cool shirt", unit_price: 1600, merchant_id: @merchant_5.id)
    @item_6 = Item.create!(name: "shirt with flowers", description: "super cool shirt", unit_price: 1300, merchant_id: @merchant_6.id)
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
    @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2010-03-12 09:50:09 UTC")
    @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2017-03-12 06:50:09 UTC")
    @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2009-03-12 09:50:09 UTC")
    @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
    @invoice_7 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_8 = Invoice.create(customer_id: @customer_2.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_9 = Invoice.create(customer_id: @customer_3.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_10 = Invoice.create(customer_id: @customer_3.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_12 = Invoice.create(customer_id: @customer_4.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_11 = Invoice.create(customer_id: @customer_5.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_13 = Invoice.create(customer_id: @customer_5.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: 1400, status: "pending")
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: 1000, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 1, unit_price: 1700, status: "shipped")
    @invoice_item_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_4, quantity: 1, unit_price: 700, status: "shipped")
    @invoice_item_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_5, quantity: 1, unit_price: 1600, status: "shipped")
    @invoice_item_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_6, quantity: 1, unit_price: 1300, status: "shipped")
    @invoice_item_7 = InvoiceItem.create!(item: @item_1, invoice: @invoice_7, quantity: 2, unit_price: 1400, status: "shipped")
    @invoice_item_8 = InvoiceItem.create!(item: @item_1, invoice: @invoice_8, quantity: 2, unit_price: 1400, status: "shipped")
    @invoice_item_9 = InvoiceItem.create!(item: @item_1, invoice: @invoice_9, quantity: 2, unit_price: 1400, status: "shipped")
    @invoice_item_10 = InvoiceItem.create!(item: @item_1, invoice: @invoice_10, quantity: 2, unit_price: 1400, status: "shipped")
    @invoice_item_11 = InvoiceItem.create!(item: @item_1, invoice: @invoice_11, quantity: 2, unit_price: 1400, status: "shipped")
    @invoice_item_12 = InvoiceItem.create!(item: @item_1, invoice: @invoice_12, quantity: 2, unit_price: 1400, status: "shipped")
    @invoice_item_13 = InvoiceItem.create!(item: @item_1, invoice: @invoice_13, quantity: 2, unit_price: 1400, status: "shipped")
    Transaction.create!(invoice_id: @invoice_1.id, result: "success")
    Transaction.create!(invoice_id: @invoice_2.id, result: "success")
    Transaction.create!(invoice_id: @invoice_3.id, result: "success")
    Transaction.create!(invoice_id: @invoice_4.id, result: "success")
    Transaction.create!(invoice_id: @invoice_5.id, result: "success")
    Transaction.create!(invoice_id: @invoice_6.id, result: "success")
    Transaction.create!(invoice_id: @invoice_8.id, result: "success")
    Transaction.create!(invoice_id: @invoice_10.id, result: "success")
    Transaction.create!(invoice_id: @invoice_11.id, result: "success")
    Transaction.create!(invoice_id: @invoice_12.id, result: "success")
    Transaction.create!(invoice_id: @invoice_9.id, result: "success")
    Transaction.create!(invoice_id: @invoice_13.id, result: "success")
  expect(Customer.top_admin_5_customers).to eq([@customer_1, @customer_3, @customer_5, @customer_2, @customer_4])
  end
end
