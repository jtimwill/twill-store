class CreateShippingOptions < ActiveRecord::Migration
  def change
    create_table :shipping_options do |t|
      t.string :title
      t.integer :cost
      t.timestamps null: false
    end
  end
end
