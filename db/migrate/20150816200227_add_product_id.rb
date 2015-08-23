class AddProductId < ActiveRecord::Migration
  def change
    add_column :products, :order_id, :integer
  end
end
