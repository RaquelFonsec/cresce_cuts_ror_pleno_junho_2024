require 'httparty'


API_URL = 'https://fakestoreapi.com/products'


def fetch_products
  response = HTTParty.get(API_URL)
  if response.success?
    return JSON.parse(response.body)
  else
    puts "Erro ao obter produtos da API Fake Store: #{response.code}"
    return []
  end
end


CampaignHistory.destroy_all
Discount.destroy_all
Campaign.destroy_all
Product.destroy_all


products = fetch_products


products.each_with_index do |product_data, index|
  product = Product.create(
    name: product_data['title'],
    price: product_data['price'].to_f
  )

  campaign = Campaign.create(
    title: "Campanha #{index + 1}",
    description: "Promoção de #{rand(5..30)}% de desconto!",
    start_date: Date.today,
    end_date: Date.today + 7.days,
    discounted_price: product.price * (1 - rand(5..30).to_f / 100),
    product: product,
    status: 'ativo',
    created_by: 'admin'
  )

  Discount.create(
    campaign: campaign,
    discount_type: 'percentual',
    discount_value: rand(5..30)
  )

  puts "Criada campanha: #{campaign.title} - Desconto: #{campaign.discount.discount_value}%"
end

puts "Seed de campanhas com desconto percentual concluído!"
