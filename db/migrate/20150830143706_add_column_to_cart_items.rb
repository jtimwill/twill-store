class AddColumnToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_items, :quantity, :int
  end
end
