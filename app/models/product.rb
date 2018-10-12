class Product < ApplicationRecord
  PER_PAGE = 10
  has_many :orders
  has_many :users, :through => :orders
  has_one :cart_item
  has_many :reviews
  validates_presence_of :title, uniqueness: true
  validates_presence_of :description, uniqueness: true

  def self.products_on_page(page_number)
    limit(PER_PAGE).offset(PER_PAGE*(page_number-1))
  end

  def self.number_of_pages
    (all.size.to_f/PER_PAGE).ceil
  end

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("LOWER(title) LIKE ?", "%#{search_term.downcase}%").order("price DESC")
  end

  def show_rating
    if rating
      "#{rating.round(1)}/5"
    else
      "no rating"
    end
  end

  def add_rating
    total = (reviews.count-1)*rating.to_f + reviews.last.rating
    average_rating = total/reviews.count
    update_attributes(rating: average_rating.round(2))
  end

  def remove_rating
    if reviews.count == 1
      update_attributes(rating: nil)
    else
      total = reviews.count*rating.to_f - reviews.last.rating
      average_rating = total/(reviews.count - 1)
      update_attributes(rating: average_rating.round(2))
    end
  end
end
