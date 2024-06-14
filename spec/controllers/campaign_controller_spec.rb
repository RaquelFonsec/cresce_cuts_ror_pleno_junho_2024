require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:product) { Product.create!(name: "Test Product", price: 100) }
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:valid_attributes) do
    {
      title: "Test Campaign",
      description: "Test Description",
      start_date: Date.today,
      end_date: Date.today + 1.day,
      product_id: product.id,
      discount_attributes: { discount_type: "percentage", discount_value: 10 }
    }
  end

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new campaign" do
        expect {
          post :create, params: { campaign: valid_attributes }
        }.to change(Campaign, :count).by(1)
      end

      it "redirects to the campaigns index" do
        post :create, params: { campaign: valid_attributes }
        expect(response).to redirect_to(campaigns_path) # Corrigido para redirecionar para campaigns_path
      end
    end
  end
end
