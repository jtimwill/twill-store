class Product < ActiveRecord::Base
  has_many :orders
  has_many :users, :through => :orders
  has_one :cart_item
  has_many :reviews
  validates_presence_of :title, :description
end
