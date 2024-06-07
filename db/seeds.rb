require 'net/http'
require 'json'

# Limpa os dados do banco de dados antes de criar novos registros
Campaign.destroy_all
User.destroy_all

# Cria um usuário administrador
admin_user = User.create!(email: 'admin@email.com', password: '123456')

# Método para obter produtos da Fake Store API
def fetch_fake_store_products
  url = 'https://fakestoreapi.com/products'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

# Obtém os produtos da API Fake Store
products = fetch_fake_store_products

# Cria campanhas de desconto para cada produto retornado da API, associando-as ao usuário administrador
products.each do |product|
  Campaign.create!(
    title: product['title'],
    description: product['description'],
    start_date: Date.today,
    end_date: Date.today + 1.month, 
    product_id: product['id'],
    user: admin_user
  )
end
