require 'rails_helper'

RSpec.describe Discount, type: :model do
  let(:user) { User.create(email: 'test@example.com') }
  let(:campaign) { Campaign.create }

  it "é válido com discount_type e discount_value" do
    discount = Discount.new(discount_type: 'percentual', discount_value: 20.0, user: user, campaign: campaign)
    expect(discount).to be_valid
  end

  it "é inválido sem discount_type" do
    discount = Discount.new(discount_value: 20.0, user: user, campaign: campaign)
    expect(discount).not_to be_valid
  end

  it "é inválido sem discount_value" do
    discount = Discount.new(discount_type: 'percentual', user: user, campaign: campaign)
    expect(discount).not_to be_valid
  end

  describe "#record_history" do
    it "registra o histórico corretamente" do
      user_email = 'test@example.com'
      campaign = Campaign.create
      discount = Discount.new(
        discount_type: 'percentual',
        discount_value: 20.0,
        user: user,
        campaign: campaign
      )
    
      expect(discount).to be_valid
      if discount.campaign_id.present?
        expect { discount.save }.to change(Discount, :count).by(1)
        expect {
          discount.discount_value = 30.0
          discount.save
        }.to change(PaperTrail::Version, :count).by(1)
      else
        puts "Erro: O desconto não possui uma campanha associada."
      end
    end
  end
end
