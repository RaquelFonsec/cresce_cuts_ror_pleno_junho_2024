require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create(name: 'Test Product', price: 100) }

  let(:valid_attributes) do
    {
      title: 'Campaign Title',
      description: 'Campaign Description',
      start_date: Date.today,
      end_date: Date.today + 1.week,
      product_id: product.id,
      user_id: user.id
    }
  end

  let(:valid_discount_attributes) do
    { discount_attributes: { discount_type: 'De', discount_value: 10 } }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      description: 'Campaign Description',
      start_date: Date.today,
      end_date: Date.today + 1.week,
      product_id: product.id,
      user_id: user.id
    }
  end

  let(:invalid_discount_attributes) do
    { discount_attributes: { discount_type: nil, discount_value: 10 } }
  end

  before { sign_in user }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new campaign" do
        expect { post :create, params: { campaign: valid_attributes.merge(valid_discount_attributes) } }
          .to change(Campaign, :count).by(1)
      end

      it "redirects to the created campaign" do
        post :create, params: { campaign: valid_attributes.merge(valid_discount_attributes) }
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "renders the new template" do
        post :create, params: { campaign: invalid_attributes }
        expect(response).to have_http_status(200)
      end

      it "renders the new template when discount attributes are invalid" do
        post :create, params: { campaign: invalid_attributes.merge(invalid_discount_attributes) }
        expect(response).to have_http_status(200)
      end
    end
  end
end
