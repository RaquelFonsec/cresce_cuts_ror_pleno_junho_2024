require 'rails_helper'

RSpec.describe Discount, type: :model do
  let(:product) { Product.create!(name: "Test Product", price: 100) }
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:campaign) { Campaign.create!(title: "Test Campaign", description: "Test Description", start_date: Date.today, end_date: Date.today + 1.day, product: product, user: user) }
  let(:discount) { Discount.new(discount_type: "percentual", discount_value: 20.0, campaign: campaign, user: user) }

  it 'creates a campaign history record after saving' do
    expect {
      discount.save
    }.to change { CampaignHistory.count }.by(1)
  end
end
