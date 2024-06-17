require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  include ActionDispatch::TestProcess::FixtureFile

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @product = FactoryBot.create(:product)
  end

  let(:valid_attributes) do
    {
      product_id: @product.id,
      user_id: @user.id,
      description: "Sample Campaign",
      start_date: Date.today,
      end_date: Date.today + 1.month,
      status: :ativo,
      image: fixture_file_upload(Rails.root.join('spec/support/assets/test_image.png'), 'image/png'),
      discount_attributes: {
        discount_type: "percentage",
        discount_value: 10,
        user_id: @user.id
      }
    }
  end

  let(:invalid_attributes) do
    {
      description: nil
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      campaign = FactoryBot.create(:campaign, user: @user, product: @product)
      get :index
      expect(response).to be_successful
      expect(assigns(:campaigns)).to include(campaign)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      campaign = FactoryBot.create(:campaign, user: @user, product: @product)
      get :show, params: { id: campaign.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      campaign = FactoryBot.create(:campaign, user: @user, product: @product)
      get :edit, params: { id: campaign.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Campaign" do
        expect {
          post :create, params: { campaign: valid_attributes }
          expect(assigns(:campaign).errors.full_messages).to be_empty
        }.to change(Campaign, :count).by(1)
      end

      it "redirects to the campaign list" do
        post :create, params: { campaign: valid_attributes }
        expect(response).to redirect_to(campaigns_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { campaign: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          description: "Updated Campaign",
          image: fixture_file_upload(Rails.root.join('spec/support/assets/test_image.png'), 'image/png')
        }
      end

      it "updates the requested campaign" do
        campaign = FactoryBot.create(:campaign, user: @user, product: @product)
        put :update, params: { id: campaign.to_param, campaign: new_attributes }
        campaign.reload
        expect(campaign.description).to eq("Updated Campaign")
      end

      it "redirects to the campaign" do
        campaign = FactoryBot.create(:campaign, user: @user, product: @product)
        put :update, params: { id: campaign.to_param, campaign: new_attributes }
        expect(response).to redirect_to(campaign)
      end
    end

    context "with invalid params" do
      it "returns a redirect to the edit template" do
        campaign = FactoryBot.create(:campaign, user: @user, product: @product)
        put :update, params: { id: campaign.to_param, campaign: invalid_attributes }
        expect(response).to redirect_to(edit_campaign_path(campaign))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested campaign" do
      campaign = FactoryBot.create(:campaign, user: @user, product: @product)
      expect {
        delete :destroy, params: { id: campaign.to_param }
      }.to change(Campaign, :count).by(-1)
    end

    it "redirects to the campaigns list" do
      campaign = FactoryBot.create(:campaign, user: @user, product: @product)
      delete :destroy, params: { id: campaign.to_param }
      expect(response).to redirect_to(campaigns_path)
    end
  end
end
