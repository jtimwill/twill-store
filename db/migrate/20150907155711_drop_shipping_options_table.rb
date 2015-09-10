class DropShippingOptionsTable < ActiveRecord::Migration
  def change
    drop_table :shipping_options
  end
end
