require 'rails_helper'
require 'spec_helper'

describe Order do
  it {should belong_to(:user).optional}
  it {should belong_to(:product).optional}
end
