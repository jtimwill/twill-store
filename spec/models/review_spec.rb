require 'rails_helper'
require 'spec_helper'

describe Review do
  it {should belong_to(:user)}
  it {should belong_to(:product)}
  it {should validate_presence_of(:content)}
  it {should validate_presence_of(:rating)}
end
