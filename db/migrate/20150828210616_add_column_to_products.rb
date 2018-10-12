class AddColumnToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price, :int
  end
end
