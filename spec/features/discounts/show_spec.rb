require 'rails_helper'

RSpec.describe 'discount show page' do
  before :each do
    @merchant = Merchant.create!(name: "Bobs Burgers")
    @discount_1 = @merchant.discounts.create!(name:'Discount 1', percentage: 25, threshold: 4)
    @discount_2 = @merchant.discounts.create!(name:'Discount 2', percentage: 15, threshold: 2)
    @discount_3 = @merchant.discounts.create!(name:'Discount 3', percentage: 55, threshold: 15)
    visit merchant_discount_path(@merchant, @discount_1)
  end

  it 'shows all bulk discount attributes' do
    save_and_open_page
    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_1.percentage)
    expect(page).to have_content(@discount_1.threshold)
  end
end
