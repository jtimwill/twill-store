class RemoveLargeImagePathFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :large_image_path
  end
end
