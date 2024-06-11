
require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(name: 'Test Product', price: 100) }

  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a new campaign and redirects to campaigns_path" do
      post :create, params: { campaign: { start_date: Date.today, end_date: Date.today + 1.week, product_id: product.id, status: "ativo", discounts_attributes: { "0" => { discount_type: "fixed", discount_value: 10, user_id: user.id } } } }

      if assigns(:campaign).errors.any?
        puts assigns(:campaign).errors.full_messages
      end

      expect(response).to redirect_to(campaigns_path)
    end
  end
end
