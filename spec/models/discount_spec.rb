RSpec.describe Discount, type: :model do
    let(:user) { User.create(email: "test@example.com", password: "password") }
    let(:product) { Product.create(name: "Test Product", price: 100) } 
    let(:campaign) { Campaign.create(title: "Test Campaign", user: user, product_id: product.id, description: "Test Description", start_date: Date.today, end_date: Date.today + 1.month) }
  
    it "callbacks sets default status to active on create" do
      expect(user).to be_valid
      expect(product).to be_valid
      expect(campaign).to be_valid
  
      discount = Discount.new(campaign_id: campaign.id, user_id: user.id, discount_type: 'De', discount_value: 10)
      expect { discount.save }.to change { Discount.count }.by(1)
      expect(discount.status).to eq('active')
    end
  
    it "#discount_price when discount type is 'De' calculates the correct discount price" do
      expect(user).to be_valid
      expect(product).to be_valid
      expect(campaign).to be_valid
  
      discount = Discount.new(campaign_id: campaign.id, user_id: user.id, discount_type: 'De', discount_value: 10)
      expect { discount.save }.to change { Discount.count }.by(1)
      expect(discount.discount_price).to eq(product.price - 10)
    end
  
    it "#discount_price when discount type is 'Por' calculates the correct discount price" do
      expect(user).to be_valid
      expect(product).to be_valid
      expect(campaign).to be_valid
  
      discount = Discount.new(campaign_id: campaign.id, user_id: user.id, discount_type: 'Por', discount_value: 20)
      expect { discount.save }.to change { Discount.count }.by(1)
      expect(discount.discount_price).to eq(product.price * 0.8)
    end
  end
  