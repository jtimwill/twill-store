require 'rails_helper'
require 'spec_helper'

describe Product do
  it {should have_many(:orders)}
  it {should have_many(:users).through(:orders)}
  it {should have_many(:reviews)}
  it {should have_one(:cart_item)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
end
