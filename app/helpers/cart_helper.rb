module CartHelper
  def cart_item_count
    cart = session[:cart] ||= Cart.new 
    cart.cart_item_count
  end
end