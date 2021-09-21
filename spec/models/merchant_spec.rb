require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  # Enum status tests

  describe 'class methods' do
    it 'can return the items that have not shipped and has a link to the original invoice' do
      merchant = Merchant.create!({name: "Fucko"})
      item_1 = merchant.items.create!({name: "chicken burger", description: "eat the chicken", unit_price: 45000 })
      item_2 = merchant.items.create!({name: "dog burger", description: "eat the dog", unit_price: 45641})
      item_3 = merchant.items.create!({name: "bird burger", description: "eat the bird", unit_price: 30000})
      item_4 = merchant.items.create!({name: "f burger", description: "eat the f", unit_price: 20000})
      item_5 = merchant.items.create!({name: "suck burger", description: "eat the suck", unit_price: 20000})
      item_6 = merchant.items.create!({name: "goop", description: "dog", unit_price: 34000})


      customer_1 = Customer.create!({first_name: "Dog", last_name: "Man"})
      invoice_1 = customer_1.invoices.create!({status: "in progress"})
      pair_1 = invoice_1.invoice_items.create!({item_id: item_1.id, quantity: 2, unit_price: 13435, status: "packaged"})
      
      invoice_2 = customer_1.invoices.create!({status: "in progress"})
      pair_2 = invoice_2.invoice_items.create!({item_id: item_2.id, quantity: 1, unit_price: 13435, status: "packaged"})

      invoice_3 = customer_1.invoices.create!({status: "in progress"})
      pair_3 = invoice_3.invoice_items.create!({item_id: item_3.id, quantity: 2, unit_price: 13435, status: "packaged"})

      customer_2 = Customer.create!({first_name: "Fuck", last_name: "Dog"})

      invoice_4 = customer_2.invoices.create!({status: "in progress"})
      pair_4 = invoice_4.invoice_items.create!({item_id: item_4.id, quantity: 1, unit_price: 13435, status: "packaged"})

      invoice_5 = customer_2.invoices.create!({status: "in progress"})
      pair_5 = invoice_5.invoice_items.create!({item_id: item_5.id, quantity: 1, unit_price: 13435, status: "pending"})

      expect(merchant.items_ready_to_ship).to eq([item_1, item_2, item_3, item_4])
    end

  before :each do
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @customer_2 = Customer.create(first_name: 'Sally', last_name: 'Johnson')
    @customer_3 = Customer.create(first_name: 'Bill', last_name: 'Smith')
    @customer_4 = Customer.create(first_name: 'Sara', last_name: 'Smith')
    @customer_5 = Customer.create(first_name: 'Santa', last_name: 'Claus')
    @customer_6 = Customer.create(first_name: 'Barry', last_name: 'Jones')
    @merchant_1 = Merchant.create!(name: "Cool Shirts")
    @merchant_2 = Merchant.create!(name: "Ugly Shirts", status: 1)
    @merchant_3 = Merchant.create!(name: "Rad Shirts")
    @merchant_4 = Merchant.create!(name: "Bad Shirts", status: 1)
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

  end

  describe 'class methods' do
    it 'returns the top 5 merchants based on revenue' do

      expect(Merchant.top_5_merchants).to eq([@merchant_3, @merchant_5, @merchant_1, @merchant_6, @merchant_2])
    end
    it 'returns a list of all enabled merchants' do
      expect(Merchant.enabled_list).to eq([@merchant_1,@merchant_3, @merchant_5, @merchant_6 ])
    end

    it 'returns a list of all enabled merchants' do
      expect(Merchant.disabled_list).to eq([@merchant_2, @merchant_4])
    end
  end

  describe 'instance methods' do
    it 'returns the best day of revenue for a specific merchant' do
      expect(@merchant_1.merchant_best_day_ever).to eq(@invoice_7.created_at.strftime("%m/%d/%y"))
    end
  end
end
