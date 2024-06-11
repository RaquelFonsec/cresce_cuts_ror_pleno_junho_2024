require 'rails_helper'

RSpec.describe Discount, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(name: 'Test Product', price: 100) }
  let(:campaign) { Campaign.create!(start_date: Date.today, end_date: Date.today + 1.week, product: product, status: "ativo", user: user) }

  it "is valid with valid attributes" do
    discount = Discount.new(discount_type: "fixed", discount_value: 20, campaign: campaign, user: user)
    expect(discount).to be_valid
  end
end
