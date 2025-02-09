require 'rails_helper'

RSpec.describe 'Admin Invoice Show page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @customer_2 = Customer.create(first_name: 'Susie', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'cancelled')
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'in progress')
    @invoice_3 = Invoice.create(customer_id: @customer_2.id, status: 'completed')
    @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_1.id)
    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1200, status: "pending")
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1200, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 1200, status: "shipped")
    @invoice_item_4 = InvoiceItem.create!(item: @item_3, invoice: @invoice_2, quantity: 3, unit_price: 1200, status: "shipped")
    @discount = @merchant_1.discounts.create!(name: 'Discount 1', percentage: 15, threshold: 3)

  end

  it 'shows invoice information' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
  end

  it 'lists all items on invoice with name, quantity, price, item status' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'shows the total revenue generated from the invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.total_revenue)
  end

  it 'has a select field to update the status' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.status)
    select 'completed', from: "Status"
    click_on "Update Invoice Status"
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    expect(page).to have_content("Status has been updated")
    expect(page).to have_content(@invoice_1.status)
  end

  it 'shows the total discounted revenue from the invoice' do
    visit "/admin/invoices/#{@invoice_2.id}"
    expect(page).to have_content(@invoice_2.total_revenue_discounted)
  end
end
