require 'ruleby'
class CartsController < ApplicationController
  include Ruleby
  def update
      get_cart
      @product = Product.find(params[:product_id])
      #ruleby code 

      engine :engine do |e|
        r = StoreRulebook.new(e)
        r.rules
        r.discount_products ['X', 'Y', 'Z']
        
        e.assert current_user
        e.assert @product
        
        e.match
      end
      @cart << @product
      flash[:notice] = "Successfully added product to cart."
      redirect_to root_url
  end
  
  def show
    get_cart
  end
  
  def checkout
    session["#{current_user.id}_cart"] = []
    flash[:notice] = 'Successfully checked out.'
    redirect_to root_url
  end
  
  private
  def get_cart
    session["#{current_user.id}_cart"] ||= []
    @cart = session["#{current_user.id}_cart"]
    @cart
  end
end