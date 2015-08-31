class AddColumnToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :quantity, :int
  end
end
