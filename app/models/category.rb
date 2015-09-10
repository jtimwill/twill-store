class Category < ActiveRecord::Base
  has_many :products#, -> {order("rating DESC")}
  validates_presence_of :name
end
