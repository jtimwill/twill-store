class User < ActiveRecord::Base
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}, unless: ->(user){user.uid.present?}
  has_many :cart_items
  has_many :reviews
  has_many :orders
  has_many :products, :through => :orders

  def items_in_cart
    cart_items.sum(:quantity)
  end

  def cart_total
    total_array = cart_items.map do |item|
      item.product.price*item.quantity
    end
    total_array.sum.round(2)
  end

  def self.omniauthorize(auth_hash)
    user = find_or_create_by(uid: auth_hash.uid, provider: auth_hash.provider)
    user.username = auth_hash.info.name
    user.email = auth_hash.info.email
    user.save
    user
  end
end
