require 'rails_helper'

RSpec.describe InvoiceItem do
  it {should belong_to :invoice}
  it {should belong_to :item}
  it {should have_many(:merchants).through(:item)}

  describe 'instance methods' do
    it 'finds the discount' do
      merchant_1 = Merchant.create!(name: "Cool Shirts")
      discount_1 = merchant_1.discounts.create!(name:'Discount 1', percentage: 25, threshold: 10)
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')
      item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 11, unit_price: 1000, status: "packaged")
      expect(invoice_item1.find_discount).to eq(nil)
      expect(invoice_item2.find_discount).to eq(discount_1)
    end
    it 'calculates the price of a discount' do
      merchant_1 = Merchant.create!(name: "Cool Shirts")
      discount_1 = merchant_1.discounts.create!(name:'Discount 1', percentage: 25, threshold: 10)
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')
      item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 10, unit_price: 1000, status: "packaged")
      expect(invoice_item2.discount_unit_price).to eq(7500)

    end

    it 'calculates revenue' do
      merchant_1 = Merchant.create!(name: "Cool Shirts")
      discount_1 = merchant_1.discounts.create!(name:'Discount 1', percentage: 25, threshold: 10)
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')
      item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 10, unit_price: 1000, status: "packaged")
      expect(invoice_item1.revenue).to eq(6000)
      expect(invoice_item2.revenue).to eq(10000)
    end
    # it 'can tell if a discount applies to the invoice item' do
    #   merchant_1 = Merchant.create!(name: "Cool Shirts")
    #   discount_1 = merchant_1.discounts.create!(name:'Discount 1', percentage: 25, threshold: 10)
    #   customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
    #   invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')
    #   item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
    #   item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
    #   invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
    #   invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 10, unit_price: 1000, status: "packaged")
    #   expect(invoice_item1.discount?).to eq(false)
    #   expect(invoice_item2.discount?).to eq(true)
    # end
  end
end
