class AddReferenceIdColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :reference_id, :string
  end
end
