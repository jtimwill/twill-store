class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :slug
      t.boolean :admin
      t.string :email
      t.timestamps null: false
    end
  end
end
