require 'rails_helper'
require 'spec_helper'

describe Review do
  it {should belong_to(:user).optional}
  it {should belong_to(:product).optional}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:content)}
  it {should validate_presence_of(:rating)}
  it {should validate_uniqueness_of(:user_id).scoped_to(:product_id)}
end
