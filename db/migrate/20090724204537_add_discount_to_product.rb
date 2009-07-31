class AddDiscountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :discount, :decimal, :default => 0
  end

  def self.down
    remove_column :products, :discount
  end
end
