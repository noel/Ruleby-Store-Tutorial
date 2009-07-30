class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.references                  :user
      t.string                      :status
      t.timestamps
    end
    
    create_table :orders_products, :id => false do |t|
      t.references :orders
      t.references :products
    end
  end

  def self.down
    drop_table :orders
  end
end
