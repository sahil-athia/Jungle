class ProductsController < ApplicationController

  # this would force users to login if they want to see this page
  # before_filter :authorize
  
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

end
