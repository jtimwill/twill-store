class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
      t.timestamps null: false
    end
  end
end
