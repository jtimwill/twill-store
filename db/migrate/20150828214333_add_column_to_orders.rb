class AddColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :int
  end
end
