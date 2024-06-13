class Api::ProductsController < ApplicationController
end

module Api
    class ProductsController < ApplicationController
      def index
        @products = Product.all  
        render json: @products
      end
    end
  end
  