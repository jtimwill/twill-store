class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product, optional: true
  validates_presence_of :title, :content, :rating
  validates_uniqueness_of :user_id, scope: :product_id
end
