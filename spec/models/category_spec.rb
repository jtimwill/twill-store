require 'rails_helper'
require 'spec_helper'

describe Category do
  it {should have_many(:products)}
  it {should validate_presence_of(:name)}
end
