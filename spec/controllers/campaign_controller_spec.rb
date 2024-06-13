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
    }
  end

  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a new campaign" do
      expect {
        post :create, params: { campaign: valid_attributes }
      }.to change(Campaign, :count).by(1)
    end
  end
end
