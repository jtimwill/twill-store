require 'rails_helper'
require 'spec_helper'

describe Product do
  it {should belong_to(:order)}
  it {should have_many(:reviews)}
  it {should have_one(:cart_item)}
end
