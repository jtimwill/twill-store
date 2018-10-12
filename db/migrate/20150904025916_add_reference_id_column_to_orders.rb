class AddReferenceIdColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :reference_id, :string
  end
end
