require 'ruleby'

class StoreRulebook < Ruleby::Rulebook
  
  def rules    
    # New customers get 10% discount     
    rule :newCustomerDiscount, [User, :u, m.order_count(&c{|c| c==0 or c==nil})], [Product, :p] do |v|
      if v[:p].discount
        v[:p].discount += 10
      else
        v[:p].discount = 10
      end
    end
    
    # Customers who have purchased more than 5 times get a 5% discount 
    rule :loyalCustomerDiscount, [User, :u, m.order_count >= 5], [Product, :p] do |v|
      if v[:p].discount
        v[:p].discount += 5
      else
        v[:p].discount = 5
      end
    end
  end
  
  def discount_products(discounted_products=[])
    # Customers who buy Product X, Y or Z get a 15% discount on that product 
    discounted_products.each do |product_name|
      rule_name = "fifteenPercentOffSale_#{product_name}"
      rule rule_name.to_sym, [Product, :p, m.name == product_name] do |v|
        if v[:p].discount
          v[:p].discount += 15
        else
          v[:p].discount = 15
        end
      end      
    end    
  end  
end
