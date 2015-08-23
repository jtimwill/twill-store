class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}
  has_many :cart_items
  has_many :reviews
  has_many :orders
end
