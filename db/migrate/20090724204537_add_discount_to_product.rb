class AddDiscountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :discount, :decimal
  end

  def self.down
    remove_column :products, :discount
  end
end
