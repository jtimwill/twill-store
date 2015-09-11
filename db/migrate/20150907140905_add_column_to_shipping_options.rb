class AddColumnToShippingOptions < ActiveRecord::Migration
  def change
    add_column :shipping_options, :cost, :int
  end
end
