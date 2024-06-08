require 'rails_helper'

RSpec.describe Discount, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create(name: 'Test Product', price: 100) }
  let(:campaign) { Campaign.create(title: 'Test Campaign', description: 'Campaign Description', start_date: Date.today, end_date: Date.today + 1.week, user_id: user.id, product_id: product.id) }

  describe 'validations' do
    it { should validate_presence_of(:discount_type) }
    it { should validate_inclusion_of(:discount_type).in_array(['De', 'Por']) }
    it { should validate_presence_of(:discount_value) }
    it { should validate_numericality_of(:discount_value).is_greater_than(0) }
    
  end

  describe 'associations' do
    it { should belong_to(:campaign) }
    it { should belong_to(:user).optional }
  end

  describe 'callbacks' do
    it 'sets default status before validation on create' do
      discount = Discount.new(campaign_id: campaign.id, discount_type: 'De', discount_value: 20)
      discount.valid?
      expect(discount.status).to eq('active')
    end

    it 'sets applied info before create if user is present' do
      discount = Discount.new(campaign_id: campaign.id, user_id: user.id, discount_type: 'De', discount_value: 20)
      discount.save
      expect(discount.applied_by).to eq(user.id)
      expect(discount.applied_at).to be_present
    end
    

  describe '#discount_price' do
    it 'returns 0 if campaign is nil' do
      discount = Discount.new(discount_type: 'De', discount_value: 20)
      expect(discount.discount_price).to eq(0)
    end
end
    it 'calculates discount price correctly for discount type "De"' do
      discount = Discount.new(campaign_id: campaign.id, discount_type: 'De', discount_value: 20)
      expect(discount.discount_price).to eq(80)
    end

    it 'calculates discount price correctly for discount type "Por"' do
      discount = Discount.new(campaign_id: campaign.id, discount_type: 'Por', discount_value: 20)
      expect(discount.discount_price).to eq(80)
    end

    it 'returns 0 for invalid discount type' do
      discount = Discount.new(campaign_id: campaign.id, discount_type: 'Invalid', discount_value: 20)
      expect(discount.discount_price).to eq(0)
    end
  end
end
