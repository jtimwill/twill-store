class RemoveLargeImagePathFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :large_image_path
  end
end
