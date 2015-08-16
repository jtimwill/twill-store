class Product < ActiveRecord::Base
  belongs_to :order
  has_one :cart_item
  has_many :reviews
end
