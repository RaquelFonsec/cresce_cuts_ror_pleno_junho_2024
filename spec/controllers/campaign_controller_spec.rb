require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create(name: 'Test Product', price: 100) }
  let(:invalid_attributes) {
    { title: nil, description: 'Campaign Description', start_date: Date.today, end_date: Date.today + 1.week, product_id: product.id, user_id: user.id }
  }

  describe "POST #create" do
    context "with invalid params" do
      it "renders the new template" do
        sign_in user
        post :create, params: { campaign: invalid_attributes }
        expect(response).to have_http_status(200)
      end
    end
  end
end