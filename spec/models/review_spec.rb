require 'rails_helper'
require 'spec_helper'

describe Review do
  it {should belong_to(:user)}
  it {should belong_to(:product)}
  it {should validate_presence_of(:content)}
  it {should validate_presence_of(:rating)}
  # it {should validate_uniqueness_of(:user)} http://stackoverflow.com/questions/16268146/shoulda-matchers-should-validate-uniqueness-of-failing-with-scope
end
