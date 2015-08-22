class Product < ActiveRecord::Base
  belongs_to :order
  has_one :cart_item
  has_many :reviews
  validates_presence_of :title, :description
end
