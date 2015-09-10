class AddShippingOptionsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :shipping_option, index: true
    add_foreign_key :users, :shipping_options
  end
end
