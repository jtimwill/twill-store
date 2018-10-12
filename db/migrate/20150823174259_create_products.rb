class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :large_image_path
      t.string :small_image_path
      t.belongs_to :category, index: true
      t.timestamps null: false
    end
  end
end
