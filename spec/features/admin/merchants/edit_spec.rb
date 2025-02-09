require 'rails_helper'

RSpec.describe 'admin merchants edit page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob", created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant_2 = Merchant.create!(name: "Sara", created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it 'has a form to update merchant' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"
    fill_in :Name, with: "Bob Johnson"
    click_on("Submit")
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("Bob Johnson")
    expect(page).to have_content("Merchant has been updated")
  end

  it 'has a flash message for incomplete update form' do
    visit "/admin/merchants/#{@merchant_2.id}/edit"
    fill_in(:Name, with: '         ')
    click_on "Submit"
    expect(current_path).to eq("/admin/merchants/#{@merchant_2.id}/edit")
    expect(page).to have_content("Error: Name can't be blank")
  end
end
