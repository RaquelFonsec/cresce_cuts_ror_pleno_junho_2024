require 'rails_helper'

RSpec.describe DiscountsController, type: :controller do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(name: 'Test Product', price: 100) }
  let(:campaign) { Campaign.create!(start_date: Date.today, end_date: Date.today + 1.week, product: product, status: "ativo", user: user) }

  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a new discount for a campaign and redirects to the campaign page" do
      post :create, params: { campaign_id: campaign.id, discount: { discount_type: "fixed", discount_value: 20, status: 'active', user_id: user.id } }

      if assigns(:discount).errors.any?
        puts assigns(:discount).errors.full_messages
      end

      expect(response).to redirect_to(campaign_path(campaign))
    end
  end

  describe "PUT #update" do
    let(:discount) { campaign.discounts.create!(discount_type: "fixed", discount_value: 10, status: 'active', user_id: user.id) }

    it "updates the discount and redirects to the campaign page" do
      put :update, params: { campaign_id: campaign.id, id: discount.id, discount: { discount_type: "fixed", discount_value: 15, user_id: user.id } }

      if assigns(:discount).errors.any?
        puts assigns(:discount).errors.full_messages
      end

      expect(response).to redirect_to(campaign_path(campaign))
    end
  end

  describe "DELETE #destroy" do
    let!(:discount) { campaign.discounts.create!(discount_type: "fixed", discount_value: 10, status: 'active', user_id: user.id) }

    it "deletes the discount and redirects to the campaign page" do
      delete :destroy, params: { campaign_id: campaign.id, id: discount.id }
      expect(response).to redirect_to(campaign_path(campaign))
    end
  end
end
