class AddShippingOptionsToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :shipping_option, index: true
    add_foreign_key :orders, :shipping_options
  end
end
