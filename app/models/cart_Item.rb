class CartItem
  attr_reader :product, :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end

  def line_price
    @product.price * @quantity
  end
  
  def discounted_price
     @quantity * (product.price * ( 1 - (product.discount/100)) )
  end
  
end