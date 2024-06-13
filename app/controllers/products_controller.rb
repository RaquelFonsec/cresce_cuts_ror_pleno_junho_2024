
require 'httparty'

class ProductsController < ApplicationController
  include HTTParty
  base_uri 'https://fakestoreapi.com'

  def index
    @products = Product.all
    
  end

  def index_api
    response = self.class.get('/products')
    if response.success?
      @products = response.parsed_response
    
      render 'index_api'
    else
      render json: { error: 'Failed to fetch products from external API' }, status: :bad_request
    end
  end
end
