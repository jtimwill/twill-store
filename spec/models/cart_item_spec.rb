require 'rails_helper'
require 'spec_helper'

describe CartItem do
  it {should belong_to(:user)}
  it {should belong_to(:product)}
end
