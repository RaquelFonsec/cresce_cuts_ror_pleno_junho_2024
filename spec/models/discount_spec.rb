
require 'rails_helper'

RSpec.describe Discount, type: :model do
  let(:user) { User.create(name: 'Test User') }
  let(:product) { Product.create(name: 'Test Product', price: 100.00) }
  let(:campaign) { Campaign.new(start_date: Date.today, end_date: Date.tomorrow, product: product, status: 0) }

  it 'validates presence of discount type and value' do
    discount = Discount.new(campaign: campaign, user: user)
    expect(discount).to_not be_valid
    expect(discount.errors.full_messages).to include("Discount type can't be blank", "Discount value can't be blank")
  end

  it 'calculates discounted price correctly' do
    discount = Discount.new(discount_type: 'percentual', discount_value: 10, campaign: campaign, user: user)
    expect(discount.discount_price).to eq(90.00)
  end

  # Add more test cases as needed
end