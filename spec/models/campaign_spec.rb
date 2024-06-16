
require 'rails_helper'
RSpec.describe Campaign, type: :model do
  describe '#calculate_discounted_price' do
    let(:product) { Product.create(price: 200.0) }
    let(:campaign) { Campaign.create(product: product) }

    context 'when discount is percentual' do
      it 'calculates discounted price correctly' do
        discount = Discount.create(discount_type: 'percentual', discount_value: 25)
        campaign.discount = discount
        campaign.calculate_discounted_price
        expect(campaign.discounted_price).to eq(150.0)
      end
    end

    context 'when discount is fixo' do
      it 'calculates discounted price correctly' do
        discount = Discount.create(discount_type: 'fixo', discount_value: 50.0)
        campaign.discount = discount
        campaign.calculate_discounted_price
        expect(campaign.discounted_price).to eq(150.0)
      end
    end

    context 'when no discount is present' do
      it 'sets discounted price to original product price' do
        campaign.calculate_discounted_price
        expect(campaign.discounted_price).to eq(200.0)
      end
    end
  end
end
