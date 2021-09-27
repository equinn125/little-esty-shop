require 'rails_helper'

RSpec.describe 'the edit discount page' do
  before :each do
    @merchant = Merchant.create!(name: "Bobs Burgers")
    @discount_1 = @merchant.discounts.create!(name:'Discount 1', percentage: 25, threshold: 4)
    visit edit_merchant_discount_path(@merchant, @discount_1)
  end

  it 'has a form to edit the discount succesfully' do
    fill_in :Name, with: 'Discount 1'
    fill_in :Percentage, with: 20
    fill_in :Threshold, with: 4
    click_button "Submit"
    expect(current_path).to eq(merchant_discount_path(@merchant, @discount_1))
    expect(page).to have_content(20)
    expect(page).to have_content('Discount has been updated')
  end
end
