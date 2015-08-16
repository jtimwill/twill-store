class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :large_image_path
      t.string :small_image_path
      t.timestamps
    end
  end
end
