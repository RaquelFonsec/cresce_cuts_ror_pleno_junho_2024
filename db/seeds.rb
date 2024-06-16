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


Product.destroy_all

products = fetch_products

products.each_with_index do |product_data, index|
  product = Product.create(
    name: product_data['title'],
    price: product_data['price'].to_f
  )

  
  percentual_discount_value = rand(5..30)
  percentual_discounted_price = product.price * (1 - percentual_discount_value.to_f / 100)

  percentual_campaign = Campaign.create(
    title: "Campanha Percentual #{index + 1}",
    description: "Promoção de #{percentual_discount_value}% de desconto!",
    start_date: Date.today,
    end_date: Date.today + 7.days,
    discounted_price: percentual_discounted_price,
    product: product,
    status: 'ativo',
    created_by: 'admin'
  )

  Discount.create(
    campaign: percentual_campaign,
    discount_type: 'percentual',
    discount_value: percentual_discount_value
  )

  puts "Criada campanha percentual: #{percentual_campaign.title} - Desconto: #{percentual_campaign.discount.discount_value}%"

  
  fix_discount_value = rand(5..15).to_f
  fix_discounted_price = product.price - fix_discount_value

  fix_campaign = Campaign.create(
    title: "Campanha Fixa #{index + 1}",
    description: "Promoção de R$ #{fix_discount_value} de desconto!",
    start_date: Date.today,
    end_date: Date.today + 7.days,
    discounted_price: fix_discounted_price,
    product: product,
    status: 'ativo',
    created_by: 'admin'
  )

  Discount.create(
    campaign: fix_campaign,
    discount_type: 'fixo',
    discount_value: fix_discount_value
  )

  puts "Criada campanha fixa: #{fix_campaign.title} - Desconto: R$ #{fix_campaign.discount.discount_value}"
end

puts "Seed de campanhas com desconto percentual e fixo concluído!"
