class AddLargeImagePathsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :large_image_path1, :string
    add_column :products, :large_image_path2, :string
    add_column :products, :large_image_path3, :string
  end
end
