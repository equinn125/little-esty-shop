require 'rails_helper'

RSpec.describe 'the create a new discount page' do
  before :each do
    @merchant = Merchant.create!(name: "Bobs Burgers")
    visit new_merchant_discount_path(@merchant)
  end
  it ' has a form to create a new discount' do
    fill_in :Name, with: 'Discount 1'
    fill_in :Percentage, with: 25
    fill_in :Threshold, with: 10
    click_on "Submit"
    expect(current_path).to eq(merchant_discounts_path(@merchant))
    expect(page).to have_content("New Discount has been created")
  end
  it 'has a sad path' do
    fill_in :Name, with: 'Discount 1'
    fill_in :Percentage, with: 25
    click_on "Submit"
    expect(current_path).to eq(new_merchant_discount_path(@merchant))
    expect(page).to have_content("Error: Threshold can't be blank")
  end
end
