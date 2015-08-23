class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :reviews, :description, :content
  end
end
