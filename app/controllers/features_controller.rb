class FeaturesController < ApplicationController
  def index
    @features = Feature.all
  end
  def new
    @feature = Feature.new
  end
  def create
    @feature = Feature.create(:title=>params["feature_title"])
    @feature.scenarios.create(:scenario_title=>params["scenario_title"],
                    :feature_id=>@feature.id,
                    :given_block=>params["given_block"],
                    :when_block=>params["when_block"],
                    :then_block=>params["then_block"])
    redirect_to :action => "index"
  end
  def show
    @feature = Feature.find(params[:id])
  end
  def add_scenario
    @feature = Feature.find(params[:id])
  end
  def do_add_scenario
     Scenario.create(:scenario_title=>params["scenario_title"],
                    :feature_id=>params["feature_id"],
                    :given_block=>params["given_block"],
                    :when_block=>params["when_block"],
                    :then_block=>params["then_block"])
     redirect_to :action => "show", :id=>params["feature_id"]
  end
end
