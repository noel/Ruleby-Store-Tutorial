require 'ruleby'

class StoreRulebook < Ruleby::Rulebook
  
  def customer_discounts    
    # New customers get 10% discount     
    rule :newCustomerDiscount, [User, :u, m.order_count(&c{|c| c==0 or c==nil})], [Product, :p] do |v|
      assert Discount.new(10)
    end
    
    # Customers who have purchased more than 5 times get a 5% discount 
    rule :loyalCustomerDiscount, [User, :u, m.order_count >= 5], [Product, :p] do |v|
      assert Discount.new(5)
    end
    
    rule :applyDiscounts, [Product, :p], [Discount, :d] do |v|
      if v[:p].discount and v[:d].is_cummulative
        v[:p].discount += v[:d].amount
      else
        v[:p].discount = v[:d].amount
      end
      retract v[:d]
    end
  end
  
  def product_discounts(discounted_products=[])
    # Customers who buy Product X, Y or Z get a 15% discount on that product 
    discounted_products.each do |product_name|
      rule_name = "fifteenPercentOffSale_#{product_name}"
      rule rule_name.to_sym, [Product, :p, m.name == product_name] do |v|
        assert Discount.new(15)
      end      
    end    
  end  
end

class Discount
  attr :amount
  attr :is_cummulative
  
  def initialize(amount, is_cummulative=true)
    @amount = amount
    @is_cummulative = is_cummulative
  end
end
