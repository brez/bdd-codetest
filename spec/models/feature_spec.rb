require 'spec_helper'

describe Feature do
  it "should be valid with a title" do
    Factory(:feature).should be_valid
  end
  it "should be invalid without a title" do
    Factory.build(:feature, :title => nil).should be_invalid
  end
end
