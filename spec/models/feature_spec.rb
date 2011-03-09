require 'spec_helper'

describe Feature do
  it "should be valid with a title" do
    Feature.make(:title=>"any title must be valid").should be_valid
  end
  it "should be invalid without a title" do
    Feature.make(:title => nil).should be_invalid
  end
end
