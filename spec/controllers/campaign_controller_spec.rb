require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe "POST #create" do
    before do
      @user = User.create(email: "test@example.com", password: "password")
      sign_in @user
    end

    context "with valid parameters" do
      it "creates a new campaign and redirects to campaigns_path" do
        product = Product.create(name: "Product", price: 10)
        valid_params = {
          campaign: {
            product_id: product.id,
            description: "Some description",
            start_date: Date.today,
            end_date: Date.tomorrow,
            status: "ativo",
            discount_attributes: {
              discount_type: "valor_fixo",
              discount_value: 10
            }
          }
        }

        expect do
          post :create, params: valid_params
        end.to change(Campaign, :count).by(1)

        expect(response).to redirect_to campaigns_path
        expect(flash[:notice]).to eq("Campaign created successfully!")
      end
    end

    context "with invalid parameters" do
      it "does not create a new campaign and renders new template" do
        invalid_params = {
          campaign: {
            product_id: nil, 
            description: nil,
            start_date: nil,
            end_date: nil,
            status: nil,
            discount_attributes: {
              discount_type: nil,
              discount_value: nil
            }
          }
        }

        expect do
          post :create, params: invalid_params
        end.not_to change(Campaign, :count)

        expect(response).to render_template(:new)
      end
    end
  end
end
