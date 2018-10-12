class ShippingOption < ApplicationRecord
  has_many :orders
end
