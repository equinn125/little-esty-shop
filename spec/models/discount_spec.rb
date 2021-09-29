require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validates_presence_of(:name)}
    it {should validates_presence_of(:percentage)}
    it {should validates_presence_of(:threshold)}
  end
end
