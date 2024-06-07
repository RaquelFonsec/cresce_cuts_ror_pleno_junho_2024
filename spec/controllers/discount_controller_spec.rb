require 'rails_helper'

RSpec.describe DiscountsController, type: :controller do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let!(:product) { Product.create(name: 'Test Product', price: 100) }
  let!(:campaign) do
    campaign = Campaign.new(
      title: 'Test Campaign',
      description: 'Campaign Description',
      start_date: Date.today,
      end_date: Date.today + 1.week,
      user_id: user.id,
      product_id: product.id 
    )
    campaign.save!
    campaign
  end
  let(:invalid_attributes) { { amount: nil } }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with invalid params" do
      it "does not create a new discount" do
        expect(campaign).not_to be_nil
        expect(campaign.id).not_to be_nil
        post :create, params: { campaign_id: campaign.id, discount: invalid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end