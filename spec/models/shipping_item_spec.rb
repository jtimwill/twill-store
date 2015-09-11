require 'rails_helper'
require 'spec_helper'

describe ShippingOption do
  it {should have_many(:orders)}
end
