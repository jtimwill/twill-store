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

  def show_rating
    if rating
      "#{rating.round(1)}/5"
    else
      "no rating"
    end
  end

  def add_rating
    new_rating = ((reviews.count-1)*rating + reviews.last.rating)/reviews.count
    update_attributes(rating: new_rating)
  end

  def remove_rating
    if reviews.count == 1
      update_attributes(rating: nil)
    else
      new_rating = (reviews.count*rating - reviews.last.rating)/(reviews.count - 1)
      update_attributes(rating: new_rating)
    end
  end
end
