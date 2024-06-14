# spec/models/campaign_spec.rb

require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:product) { Product.create(name: 'Product A', price: 100.0) }

  it 'creates a campaign with valid attributes' do
    campaign_params = {
      product_id: product.id,
      description: 'Test Campaign',
      start_date: Date.today,
      end_date: Date.tomorrow,
      status: :ativo
    }
    campaign = user.campaigns.new(campaign_params)
    expect(campaign.save).to be_truthy
    expect(campaign.errors.full_messages).to be_empty  # Certifica-se de que não há erros de validação
    expect(campaign.id).not_to be_nil  # Verifica se a campanha foi salva com sucesso e possui um ID válido
  end
end
