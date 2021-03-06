require 'ruleby'
class CartsController < ApplicationController
  include Ruleby
  
  def update
    @cart = find_cart 
    @product = Product.find(params[:product_id])

    #ruleby code     
    engine :engine do |e|
      r = CartRulebook.new(e)
      
      # initialize the rules we want to match against our facts
      r.customer_discounts
      r.product_discounts ['X', 'Y', 'Z']
      
      # assert some facts to working memory
      e.assert current_user
      e.assert @product
      
      # fire the activations that were created by matching rules
      # to facts at assert time
      e.match
    end
    
    @cart.add_product(@product)
    flash[:notice] = "Successfully added product to cart."
    redirect_to cart_path

  end
  
  def show
    @cart = find_cart
  end
  
  def checkout
    @cart = find_cart 

    unless @cart.cart_item_count == 0
      current_user.order_count += 1
      current_user.save
    end

    session[:cart] = nil
    flash[:notice] = 'Successfully checked out.'
    
    redirect_to root_url
  end
  
  private
    def find_cart
      session[:cart] ||= Cart.new
    end

end