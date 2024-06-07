require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:user) { User.create(email: "raque-leto@hotmail.com", password: "123456") }
  let(:product) { Product.create(name: "Test Product", price: 100) }

  describe "validations" do
    it "is valid with valid attributes" do
      campaign = Campaign.new(
        title: "Summer Sale",
        description: "Discounts on summer products",
        start_date: Date.today,
        end_date: Date.today + 30.days,
        product: product,
        user: user
      )
      expect(campaign).to be_valid
    end
  
    it "is invalid without a title" do
      campaign = Campaign.new(
        description: "Test Description",
        start_date: Date.today,
        end_date: Date.today + 30.days,
        product: product,
        user: user
      )
      expect(campaign).to_not be_valid
    end
  
    it "is invalid if end date is before start date" do
      campaign = Campaign.new(
        title: "Invalid Campaign",
        description: "Test Description",
        start_date: Date.today,
        end_date: Date.today - 1.day,
        product: product,
        user: user
      )
      campaign.valid?
      expect(campaign.errors.full_messages).to include("End date must be after start date")
    end
  end
  
  describe "callbacks" do
    it "sets initial status before creation" do
      campaign = Campaign.new(
        title: "Test Campaign",
        description: "Test Description",
        start_date: Date.today,
        end_date: Date.today + 30.days,
        product: product,
        user: user
      )
      campaign.save
      expect(campaign.status).to eq("pending")
    end
  end
  
  describe "methods" do
    it "calculates discounted price based on product price and discount rate" do
      campaign = Campaign.new(
        title: "Summer Sale",
        description: "Discounts on summer products",
        start_date: Date.today,
        end_date: Date.today + 30.days,
        product: product,
        user: user
      )
      campaign.discount_rate = 0.2
      campaign.calculate_discounted_price
      expect(campaign.discounted_price).to eq(80) 
    end
  end
end
