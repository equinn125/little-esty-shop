require 'rails_helper'

RSpec.describe 'Discount index' do
  before :each do
    @merchant = Merchant.create!(name: "Bobs Burgers")
    @discount_1 = @merchant.discounts.create!(name:'Discount 1', percentage: 25, threshold: 4)
    @discount_2 = @merchant.discounts.create!(name:'Discount 2', percentage: 15, threshold: 2)
    @discount_3 = @merchant.discounts.create!(name:'Discount 3', percentage: 55, threshold: 15)
    visit merchant_discounts_path(@merchant)
  end
  it 'shows the merchants bulk discounts' do
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_1.percentage)
    expect(page).to have_content(@discount_1.threshold)
  end

  it 'has a link to the discount show page' do
    within "#discount-#{@discount_1.id}" do
      click_link "#{@discount_1.name}"
      expect(current_path).to eq(merchant_discount_path(@merchant, @discount_1))
    end
  end

  it 'has a link to create a new discount' do
    click_link "Create Discount"
    expect(current_path).to eq(new_merchant_discount_path(@merchant))
  end
end
