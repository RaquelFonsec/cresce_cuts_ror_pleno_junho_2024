require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it "is valid with valid attributes" do
    user = User.create(email: "test@example.com", password: "password") 
    product = Product.create(name: "Test Product", price: 100) 
    campaign = Campaign.new(title: "Test Campaign", description: "Test Description", start_date: Date.today, end_date: Date.tomorrow, product: product, user: user)
    expect(campaign).to be_valid
  end
end
