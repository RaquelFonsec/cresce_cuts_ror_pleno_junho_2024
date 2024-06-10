
class Api::ProductsController < ApplicationController
    # GET /api/products
    def index
      @products = Product.all
      render json: @products
    end
  
    # Outras ações do controlador
  end
  