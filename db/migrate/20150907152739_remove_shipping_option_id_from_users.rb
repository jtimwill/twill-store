class RemoveShippingOptionIdFromUsers < ActiveRecord::Migration
  def change
    remove_foreign_key :users, :shipping_options
    remove_column :users, :shipping_option_id
  end
end
