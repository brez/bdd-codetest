require 'spec_helper'

describe FeaturesController do
  context "#index" do
    it "should provide an index method that returns all features to the view" do
      @features = Array.new(3) { Factory(:feature) }
      Feature.stub!(:find).and_return(@features)
      get :index
      assigns[:features].should == @features
    end
    it "should provide an index method that returns an empty array if there are no features" do
      get :index
      assigns[:features].empty?.should be(true)
    end
    it "should render the index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
