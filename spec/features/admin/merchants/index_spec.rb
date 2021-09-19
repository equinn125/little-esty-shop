require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
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
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'completed')
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'completed')
    @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 'completed')
    @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 'completed')
    @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 'completed')
    @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 'completed')
    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: 1400, status: "pending")
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: 1000, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 1, unit_price: 1700, status: "shipped")
    @invoice_item_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_4, quantity: 1, unit_price: 700, status: "shipped")
    @invoice_item_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_5, quantity: 1, unit_price: 1600, status: "shipped")
    @invoice_item_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_6, quantity: 1, unit_price: 1300, status: "shipped")
    Transaction.create!(invoice_id: @invoice_1.id, result: "success")
    Transaction.create!(invoice_id: @invoice_2.id, result: "success")
    Transaction.create!(invoice_id: @invoice_3.id, result: "success")
    Transaction.create!(invoice_id: @invoice_4.id, result: "success")
    Transaction.create!(invoice_id: @invoice_5.id, result: "success")
    Transaction.create!(invoice_id: @invoice_6.id, result: "success")

  end

  it 'lists all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end

  it 'has a link to the merchants show page' do
    visit '/admin/merchants'
    within("#all_merchants") do
      click_on(@merchant_1.name)
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end

    visit '/admin/merchants'
    within("#all_merchants") do
      click_on(@merchant_2.name)
      expect(current_path).to eq("/admin/merchants/#{@merchant_2.id}")
    end
  end

  it 'has a link for new merchant' do
    visit '/admin/merchants'
    click_on("New Merchant")
    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'lists top 5 merchants by revenue as links to their respective show pages' do
    visit '/admin/merchants'
    within("#top_cinco") do
      expect(@merchant_3.name).to appear_before(@merchant_5.name)
      expect(@merchant_5.name).to appear_before(@merchant_1.name)
      expect(@merchant_1.name).to appear_before(@merchant_6.name)
      expect(@merchant_6.name).to appear_before(@merchant_2.name)
      expect(page).to_not have_content(@merchant_4.name)
      click_on "#{@merchant_3.name}"
      expect(current_path).to eq("/admin/merchants/#{@merchant_3.id}")
    end
  end
end
