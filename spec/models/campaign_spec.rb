require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:product) { Product.create!(name: "Test Product", price: 100) }
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:valid_campaign_attributes) {
    {
      title: "Test Campaign",
      description: "Test Description",
      start_date: Date.today,
      end_date: Date.today + 1.day,
      product: product,
      user: user
    }
  }

  it 'is valid with valid attributes' do
    campaign = Campaign.new(valid_campaign_attributes)
    expect(campaign).to be_valid
  end

  it 'is invalid if end_date is before start_date' do
    invalid_campaign_attributes = valid_campaign_attributes.merge(end_date: Date.today - 1.day)
    campaign = Campaign.new(invalid_campaign_attributes)
    expect(campaign).to_not be_valid
    expect(campaign.errors[:end_date]).to include("deve ser após a data de início")
  end
end

