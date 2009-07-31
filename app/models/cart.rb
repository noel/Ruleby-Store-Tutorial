class Cart
  attr_reader :items
  attr_accessor :order_discount
  
  def initialize
    @items = []
    @order_discount = 0
  end

  def add_product(product)
    current_item = @items.find {|item| item.product.id == product.id}

    if current_item
      current_item.increment_quantity
    else
      @items << CartItem.new(product)
    end
  end
  
  def cart_item_count
    @items.length
  end
  
  def cart_sub_total
    @items.sum { |item| item.discounted_price } 
  end
  
  def cart_discount
    return cart_sub_total * ( @order_discount.to_f / 100 ) 
  end
  
  def cart_total
    cart_sub_total * (1 - ( @order_discount.to_f / 100) )
  end
end