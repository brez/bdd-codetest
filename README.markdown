# ENDAX, LLC - BDD Code Test 

## Introduction
The purpose of this test is to introduce and familiarize you with the Behavior Driven Development process used for all development. The test includes a feature file (explained shortly) and implementation for the first scenario. You will be expected to follow a Red / Green / Refactor process to develop the application and is likely the complete opposite of how you have developed in the past (you write a failing test first, then implement the functionality).  

Additionally, this guide will give you a step by step description of how to develop the application using BDD. Please note that failure to follow this process and/or not writing the required tests will result in failure of the test, i.e. the test is to gauge you acceptance of this process and your ability to develop with it, not necessarily to complete the application.  

Most importantly, as the step by step process will show, the BDD process is likely, very different from how you have coded up until this point. In BDD (or TDD) you are writing the test first and then implementing the functionality to get it to pass. Please don't make the observation that you don't have time to write the tests; this is simply not the case, you will always be provided ample time to implement the correct process (developing a solid test suite significantly reduces the number of bugs in an implementation - fixing bugs ultimately consumes enormous amounts of time, creating frustration for the client, and generally makes us look incompetent). Additionally, all development is BDD, so if you find this process not to your liking (though we suggest you give it a try first, you'll be surprised how more effective it is for the developer) then it is probably better that you stop now and withdraw your application.

## Preparing the Test
You can clone (or fork for later submission) and prepare the incomplete test by doing the following:  

Ensure you have git installed  

	$ git clone git://github.com/endax/bdd-code-test.git  

Install Gems

	$ bundle install

Start your MySQL database  

	$ rake db:create:all  

Migrate the database  

	$ rake db:migrate  

And prepare the database  

	$ rake db:test:prepare  

If you have any issues with those steps, notify your contact for assistance.  

Start by typing the following:  

	$ rake cucumber

You should see the following output (in red):  

	4 scenarios (2 failed, 1 pending, 1 passed)
	37 steps (2 failed, 28 skipped, 1 pending, 6 passed)
	0m0.210s


## Introducing the Feature File (Cucumber)
This code test is simply an application to create (and list) new feature files (we're ignoring more advanced features like editing, etc.); feature files describe a specific feature of an application and its scenarios. Cucumber uses a DSL called Gherkin to describe features that are then used by the test suite to test the application, i.e. they are the connecting link between what a client wants and an executable test suite. It's probably better to just dig into the feature file for this test, but be sure to review the Cucumber site if you get confused.  

	Feature: Create, show, and list feature files
  	  In order to create and view new feature files
  	  As an public user
  	  I want to be able to create, show, and list new features

	Scenario: View the list of features
      Given there is feature titled "Some terse yet descriptive text of what is desired"
      When I go to the "list features" page
      And I should see "Some terse yet descriptive text of what is desired"

	Scenario: Create a new feature
      When I go to the "new feature" page
      And I fill in "feature-title" with "Some terse yet descriptive text of what is desired"
      And I fill in "scenario-title" with "Some determinable business situation"
      And I fill in "given-block" with "Given some precondition"
      And I fill in "when-block" with "When some action by the actor"
      And I fill in "then-block" with "Then some testable outcome is achieved"
      And I press "submit"
      Then I should be on the "list features page"
      And I should see "Some terse yet descriptive text of what is desired"

	Scenario: Add a new scenario to a existing feature
      Given there is feature titled "Some terse yet descriptive text of what is desired"
      When I go to the "list features" page
      And I follow "Some terse yet descriptive text of what is desired"
      And I follow "Add scenario"
      And I fill in "feature-title" with "Another terse yet descriptive text of what is desired"
      And I fill in "scenario-title" with "Another determinable business situation"
      And I fill in "given-block" with "Given another precondition"
      And I fill in "when-block" with "When some action by the actor"
      And I fill in "then-block" with "Then some testable outcome is achieved yet again"
      And I press "submit"
      Then I should be on the "show feature page"
      And I should see "Another determinable business situation"

	Scenario: View a single feature
      Given there is feature titled "Some terse yet descriptive text of what is desired"
      And the feature has "feature-title" of "Some terse yet descriptive text of what is desired"
      And the feature has "scenario-title" of "Some determinable business situation"
      And the feature has "given-block" of "Given another precondition"
      And the feature has "when-block" of "When some action by the actor"
      And the feature has "then-block" of "Then some testable outcome is achieved"
      When I go to the "list features" page
      And I follow "Some terse yet descriptive text of what is desired"
      Then I should see "Some terse yet descriptive text of what is desired"
      And I should see "Some determinable business situation"
      And I should see "Given another precondition"
      And I should see "When some action by the actor"
      And I should see "Then some testable outcome is achieved"


### BDD Technology Stack
* [Cucumber](http://cukes.info/) - provides the parsing of the Gherkin language
* [Webrat](http://gitrdoc.com/brynary/webrat/tree/master) - provides the headless processing of the application from an external perspective (integration test)
* [Machinist](https://github.com/notahat/machinist) - provides a mocking strategy for your models
* [RSpec](http://rspec.info/documentation/) - provides the BDD framework for testing controllers and models (we won't test views in this project because they are covered by cucumber)

### Helpful documentation
* [Gherkin Language](http://wiki.github.com/aslakhellesoy/cucumber/gherkin)
* [Rspec Matchers](http://rspec.rubyforge.org/rspec/1.2.8/classes/Spec/Matchers.html)
* [ActiveRecord](http://api.rubyonrails.org/classes/ActiveRecord/Base.html)
* [ActiveRecord Validations](http://api.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html)

## Step by Step Instructions for the first scenario
The code test already includes an implementation for the first feature, View the list of features. What follows is how that implementation was done in a step by step procedure. You should read through the following steps for the first scenario and then emulate this process for further development of the code test.  

### Step One, run the feature file and note the failure  

	$ rake cucumber

Note the line:  

    TODO (Cucumber::Pending)
      ./features/step_definitions/gherkin_steps.rb:2:in /^there is feature titled "([^\"]*)"$/'
 
This means that the step definition has not yet been implemented. This step definition uses a Factory to create a Feature model for testing but we need to define the Feature model first using the rspec_model generator:  

	$ ./script/generate rspec_model feature

      create  app/models/
      create  spec/models/
      create  spec/fixtures/
      create  app/models/feature.rb
      create  spec/models/feature_spec.rb
      create  spec/fixtures/features.yml
      create  db/migrate
      create  db/migrate/20100321045705_create_features.rb

Now that we have a model, let's create the factory file and add the factory (to spec/factories.rb). Based on our first scenario, we can determine which attributes are needed:  

	Scenario: View the list of features
      Given there is feature titled "Some terse yet descriptive text of what is desired"
      When I go to the "list features" page
      And I should see "Some terse yet descriptive text of what is desired"

It looks like we need an attribute 'title' for the Feature model  

 	Factory.define :feature do |f|
      f.title 'Some terse yet descriptive text of what is desired'
    end 

Now we can go into the step definition (features/step_definitions/gherkin_steps.rb) and create the Feature factory:  

 	Given /^there is feature titled "([^\"]*)"$/ do |title|
      feature = Factory(:feature)
	end

Note that you can also override the default value with something this:  

	feature = Factory(:feature, :title => 'A different title than the default')

Now let's go back and see the scenario is passing:

	$ ./script/cucumber features/gherkin.feature

	Scenario: View the list of features                                                  # features/gherkin.feature:6
      Given there is feature titled "Some terse yet descriptive text of what is desired" # features/step_definitions/gherkin_steps.rb:1
        Mysql::Error: Table 'bddcodetest_test.features' doesn't exist: SHOW FIELDS FROM features (ActiveRecord::StatementInvalid)
        ./features/step_definitions/gherkin_steps.rb:2:in /^there is feature titled "([^\"]*)"$/'
        features/gherkin.feature:7:in Given there is feature titled "Some terse yet descriptive text of what is desired"'
 
No, it looks like we haven't defined the Feature model in our database. In fact, we haven't done much of anything as far as the Feature model is concerned, so let's pause with the feature file and implement the spec and model for Feature.

Since this is test drive development, we run the test first (spec/models/feature_spec.rb):

	$ rake spec

	You have 1 pending migrations:
      20100321045705 CreateFeatures
	  Run "rake db:migrate" to update your database then try again.

Let's add the title attribute to the migration script:

 	def self.up
      create_table :features do |t|
        t.string :title
        t.timestamps
      end
    end

	$ rake db:migrate
	$ rake db:test:prepare

Note you need to run db:test:prepare after every migration in order to reset the test database to the current schema

	$ rake spec

	(in /projects/bdd_codetest)
	.
	Finished in 0.102848 seconds
	1 example, 0 failures

Now this can be deceiving because it seems to be passing without any changes, of course we need to update the spec (spec/models/feature_spec.rb). Let's do that by adding an test for the title attribute and to validate the presence of the it.

	describe Feature do
  	  it "should be valid with a title" do
        Factory(:feature).should be_valid
      end
      it "should be invalid without a title" do
        Factory.build(:feature, :title => nil).should be_invalid
      end
    end

And when we test, we find we have a single failure:

	$rake rspec

	1)
	'Feature should be invalid without a title' FAILED
	expected invalid? to return true, got false
	./spec/models/feature_spec.rb:8:

	Finished in 0.070905 seconds
	2 examples, 1 failure

At this point we are in the Red and need to get this spec back into the Green by adding a validates_presence_of to the feature model (app/models/feature.rb):

	class Feature < ActiveRecord::Base
  	  validates_presence_of :title
	end

And test again:

	$rake rspec

	Finished in 0.071158 seconds
	2 examples, 0 failures

Now that we've got our factory, model, and spec in place we can return to the cucumber scenario:

	$ ./script/cucumber features/gherkin.feature

	Scenario: View the list of features                                                  # features/gherkin.feature:6
      Given there is feature titled "Some terse yet descriptive text of what is desired" # features/step_definitions/gherkin_steps.rb:1
      When I go to "the list features page"                                              # features/step_definitions/web_steps.rb:18
      Can't find mapping from ""the list features page"" to a path.
      Now, go and add a mapping in /projects/bdd_codetest/features/support/paths.rb (RuntimeError)
      ./features/support/paths.rb:22:in path_to'
      ./features/step_definitions/web_steps.rb:19:in /^(?:|I )go to (.+)$/'
      features/gherkin.feature:8:in When I go to "the list features page"'
      And I should see "Some terse yet descriptive text of what is desired"              # features/step_definitions/web_steps.rb:142


Now we have the Given step passing but are failing on the When step. This is because we haven't defined the 'list features' page to cucumber. We can do this by editing the features/support/paths.rb file:

    when /the list features page/
      '/features'

And run again:

	$ rake cucumber

	Scenario: View the list of features                                                  # features/gherkin.feature:6
      Given there is feature titled "Some terse yet descriptive text of what is desired" # features/step_definitions/gherkin_steps.rb:1
      When I go to "the list features page"                                              # features/step_definitions/web_steps.rb:18
      No route matches "/features" with {:method=>:get} (ActionController::RoutingError)
      (eval):2:in visit'
      ./features/step_definitions/web_steps.rb:19:in /^(?:|I )go to (.+)$/'
      features/gherkin.feature:8:in When I go to "the list features page"'
      And I should see "Some terse yet descriptive text of what is desired"              # features/step_definitions/web_steps.rb:142

Turns out we haven't defined a controller for 'features', let's do that now

	$ ./script/generate rspec_controller features

      exists  app/controllers/
      exists  app/helpers/
      create  app/views/features
      create  spec/controllers/
      create  spec/helpers/
      create  spec/views/features
      create  spec/controllers/features_controller_spec.rb
      create  spec/helpers/features_helper_spec.rb
      create  app/controllers/features_controller.rb
      create  app/helpers/features_helper.rb

And run again:

	$ rake cucumber

	Scenario: View the list of features                                                  # features/gherkin.feature:6
      Given there is feature titled "Some terse yet descriptive text of what is desired" # features/step_definitions/gherkin_steps.rb:1
      When I go to "the list features page"                                              # features/step_definitions/web_steps.rb:18
      No action responded to index. Actions:  (ActionController::UnknownAction)
      (eval):2:in visit'
      ./features/step_definitions/web_steps.rb:19:in /^(?:|I )go to (.+)$/'
      features/gherkin.feature:8:in When I go to "the list features page"'
      And I should see "Some terse yet descriptive text of what is desired"              # features/step_definitions/web_steps.rb:142

It seems I haven't described a method called 'index' on my controller, again since this is TDD, we write the spec first (spec/controllers/features_controller_spec.rb):

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

Note that I've opted to use the built in rspec mocking and stubbing - some people suggest that rspec mocking and stubbing at the controller level is more brittle (though it has better support overall for stubbing); additionally a viable option is to the shoulda library matchers as well (which also work in rspec). This is certainly part of a larger conversation on mocking and stubbing in general and what's most important is that you're doing it, how you're doing it isn't that important. In general, we supports a default stack for BDD but is very flexible in terms of specific libraries used, i.e. you should use the best available library for the task (even fixtures can be applicable in some instances).

Let's run it now:

	$rake rspec

	...FF
	1)
	ActionController::UnknownAction in 'FeaturesController#index should use provide an index method that returns all features to the view'
	No action responded to index. Actions:

We still haven't implemented the index method on the features controller (app/controllers/features_controller.rb), let's do that now:

	class FeaturesController < ApplicationController
  	  def index
        @features = Feature.all
      end
    end

Let's run it now:

	$rake rspec

	......

	Finished in 0.148571 seconds
	6 examples, 0 failures

Looking good. Heading back to the feature:

	$ rake cucumber

	Scenario: View the list of features                                                  # features/gherkin.feature:6
      Given there is feature titled "Some terse yet descriptive text of what is desired" # features/step_definitions/gherkin_steps.rb:1
      When I go to "the list features page"                                              # features/step_definitions/web_steps.rb:18
      Missing template features/index.erb in view path app/views (ActionView::MissingTemplate)
      (eval):2:in visit'
      ./features/step_definitions/web_steps.rb:19:in /^(?:|I )go to (.+)$/'
      features/gherkin.feature:8:in When I go to "the list features page"'
      And I should see "Some terse yet descriptive text of what is desired"              # features/step_definitions/web_steps.rb:142

Seems we're missing the actual view itself; let's add that now (app/views/features/index.html.erb). First we'll add a layout for the entire application (app/views/layout/application.html.erb):

	<html>
  	  <body>
        <%= yield %>
      </body>
	</html>

And the specific view for index (app/views/features/index.html.erb):

	<ul>
      <% @features.each do |feature| %>
        <li> <%= feature.title %> </li>
      <% end %>
    </ul>

One more time:

	$ rake cucumber 

	Scenario: View the list of features                                                  # features/gherkin.feature:6
      Given there is feature titled "Some terse yet descriptive text of what is desired" # features/step_definitions/gherkin_steps.rb:1
      When I go to "the list features page"                                              # features/step_definitions/web_steps.rb:18
      And I should see "Some terse yet descriptive text of what is desired"              # features/step_definitions/web_steps.rb:142

	...

	4 scenarios (2 failed, 1 pending, 1 passed)
	37 steps (2 failed, 28 skipped, 1 pending, 6 passed)
	0m0.210s

1 passing.

In terms of the development process, it's worth noting that in the process of developing the scenario for this feature, I never started up the application and checked anything with a browser. This headless approach to development is central to understanding how BDD (and TDD) is different from non test driven processes.  

Lastly, recall this is an incomplete implementation; you must continue on your own this point until you have the feature file and the specs you created passing.  

## Goals for Success
The goals for a successful submission are fairly straightforward:

* The provided feature file (cucumber) should be passing
* You should have a complete rspec test suite for both the controller and models (test with rcov) and should be passing for all specs
* You should have demonstrated that you understand the ActiveRecord associations (has_many / belongs_to) and available methods (e.g. you shouldn't be writing SQL by hand)
* You should have demonstrated a basic understanding of MVC and familiarity with the Rails framework


When testing your submission, the first thing we will do is simply run the cucumber / rspecs to confirm they are passing. If there are red tests (not passing), you will automatically fail the test, i.e. it is vital that these are passing. From there we will do a more subjective review of how you implemented the project in terms of the code itself, but is of lesser importance. Your ability to adapt to this process is more important than any previous experience.

&copy; 2011 ENDAX, LLC - Freely available for testing purposes, please cite if published. 