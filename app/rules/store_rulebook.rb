require 'ruleby'

class StoreRulebook < Ruleby::Rulebook
  
  def rules    
    # New customers get 10% discount 
    rule :newCustomerDiscount, [User, :u, m.order_count == 0], [Product, :p] do |v|
      v[:p].discount += 0.10
      modify v[:p]
    end
    
    # Customers who have purchased more than 5 times get a 5% discount 
    rule :loyalCustomerDiscount, [User, :u, m.order_count >= 5], [Product, :p] do |v|
      v[:p].discount += 0.05
      modify v[:p]
    end
    
    # Customers who buy Product X, Y or Z get a 15% discount on that product 
    ["X", "Y", "Z"].each do |product_name|
      rule_name = "fifteenPercentOffSale_#{product_name}"
      rule rule_name, [Product, :p, m.name == product_name] do |v|
        v[:p].discount += 0.15
        modify v[:p]
      end      
    end    
  end  
end
