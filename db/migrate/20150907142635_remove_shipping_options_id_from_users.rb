class RemoveShippingOptionsIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :shipping_options_id
  end
end
