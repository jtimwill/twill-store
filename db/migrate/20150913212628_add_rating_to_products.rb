class AddRatingToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :rating, :float
  end
end
