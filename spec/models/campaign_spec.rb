
require 'rails_helper'

RSpec.describe Discount, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create(name: 'Test Product', price: 100) }
  let(:campaign) do
    Campaign.create(
      title: 'Test Campaign',
      description: 'Campaign Description',
      start_date: Date.today,
      end_date: Date.today + 1.week,
      user_id: user.id,
      product_id: product.id 
    )
  end

  describe '#discount_price' do
    context 'when discount type is "De"' do
      it 'calculates discount price correctly' do
        discount = Discount.create(campaign_id: campaign.id, user_id: user.id, discount_type: 'De', discount_value: 20)
        expect(discount.discount_price).to eq(80)
      end
    end

    context 'when discount type is "Por"' do
      it 'calculates discount price correctly' do
        discount = Discount.create(campaign_id: campaign.id, user_id: user.id, discount_type: 'Por', discount_value: 20)
        expect(discount.discount_price).to eq(80)
      end
    end

    context 'when discount type is invalid' do
      it 'returns 0' do
        discount = Discount.create(campaign_id: campaign.id, user_id: user.id, discount_type: 'Invalid', discount_value: 20)
        expect(discount.discount_price).to eq(0)
      end
    end

    context 'when campaign is nil' do
      it 'returns 0' do
        discount = Discount.new(user_id: user.id, discount_type: 'De', discount_value: 20)
        expect(discount.discount_price).to eq(0)
      end
    end
  end
end
