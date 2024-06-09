
require 'httparty'

class ProductsController < ApplicationController
  include HTTParty
  
  base_uri 'https://fakestoreapi.com'

  def index_api
    response = self.class.get('/products')
    @products = response.parsed_response
  end
end
