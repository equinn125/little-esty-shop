require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
  end

  it 'can return list of items enabled per merchant' do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")

    # Item 1 will be enabled because by default items will be enabled
    @item_1 = @merchant_1.items.create!(name: "Dog", description: "Dog shirt", unit_price: 1400)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_1a = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
    @invoice_item_1b = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1000, status: "packaged")
    @transaction_1 = @invoice_1.transactions.create!(result: "success")

    # Item 2 will be false
    @item_2 = @merchant_1.items.create!(name: "burger", description: "burger shirt", unit_price: 1400, status: 1)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_2 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_2a = @invoice_2.invoice_items.create!(item: @item_2, quantity: 1, unit_price: 1400, status: "pending")
    @invoice_item_2b = @invoice_2.invoice_items.create!(item: @item_2, quantity: 4, unit_price: 1000, status: "packaged")
    @transaction_2 = @invoice_2.transactions.create!(result: "success")

    # Item 3 will be true
    @item_3 = @merchant_1.items.create!(name: "Omg", description: "Omg shirt", unit_price: 1400)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_3 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_3a = @invoice_3.invoice_items.create!(item: @item_3, quantity: 2, unit_price: 1000, status: "pending")
    @invoice_item_3b = @invoice_3.invoice_items.create!(item: @item_3, quantity: 2, unit_price: 1000, status: "packaged")
    @transaction_3 = @invoice_3.transactions.create!(result: "failed")
    @transaction_4 = @invoice_3.transactions.create!(result: "success")

    # Item 4 will be fasle
    @item_4 = @merchant_1.items.create!(name: "suck", description: "suck shirt", unit_price: 1400, status: 1)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_4 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_4a = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "pending")
    @invoice_item_4b = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "packaged")
    @transaction_5 = @invoice_4.transactions.create!(result: "success")
    @invoice_5 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_5a = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "pending")
    @invoice_item_5b = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "packaged")
    @transaction_6 = @invoice_5.transactions.create!(result: "success")

    # Item 5 will be true
    @item_5 = @merchant_1.items.create!(name: "gobble", description: "turkey shirt", unit_price: 1400)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_6 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-06-15 09:54:09 UTC")
    @invoice_item_6a = @invoice_6.invoice_items.create!(item: @item_5, quantity: 2, unit_price: 1000, status: "pending")
    @invoice_item_6b = @invoice_6.invoice_items.create!(item: @item_5, quantity: 2, unit_price: 1000, status: "packaged")
    @transaction_7 = @invoice_6.transactions.create!(result: "failed")
    @invoice_7 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-05-25 09:54:09 UTC")
    @invoice_item_7a = @invoice_7.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 1000, status: "pending")
    @invoice_item_7b = @invoice_7.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 1000, status: "packaged")
    @transaction_8 = @invoice_7.transactions.create!(result: "success")

    expect(@merchant_1.items_enabled_list).to eq([@item_1, @item_3, @item_5])
    expect(@merchant_1.items_disabled_list).to eq([@item_2, @item_4])
  end

  it 'can create a formatted price for a given num' do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")

    # Item 1 produced 2400 revenue
    @item_1 = @merchant_1.items.create!(name: "Dog", description: "Dog shirt", unit_price: 1400)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_1a = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
    @invoice_item_1b = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1000, status: "packaged")
    @transaction_1 = @invoice_1.transactions.create!(result: "success")

    collection = @merchant_1.top_5_items

    expect(collection.first.revenue_formatted).to eq("24.00")
  end

  it 'can return the best day of an item' do
    @merchant_1 = Merchant.create!(name: "Dog")
    @item_4 = @merchant_1.items.create!(name: "suck", description: "suck shirt", unit_price: 1400)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_4 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-04-27 09:54:09 UTC")
    @invoice_item_4a = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "pending")
    @invoice_item_4b = @invoice_4.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 1000, status: "packaged")
    @transaction_5 = @invoice_4.transactions.create!(result: "success")
    @invoice_5 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_5a = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "pending")
    @invoice_item_5b = @invoice_5.invoice_items.create!(item: @item_4, quantity: 1, unit_price: 1000, status: "packaged")
    @transaction_6 = @invoice_5.transactions.create!(result: "success")

    expect(@item_4.item_best_day).to eq(@invoice_4.created_at.strftime("%m/%d/%y"))
  end
end
