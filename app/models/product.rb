class Product < ActiveRecord::Base
  PER_PAGE = 10
  has_many :orders
  has_many :users, :through => :orders
  has_one :cart_item
  has_many :reviews
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def rating
    if reviews.average(:rating)
      "#{reviews.average(:rating).round(1)}/5"
    else
      "no rating"
    end
  end
end
