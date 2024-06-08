require 'rails_helper'

RSpec.describe Campaign, type: :model do
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

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:product_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
    it { should have_many(:discounts) }
  end
end
