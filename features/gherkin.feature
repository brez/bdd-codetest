Feature: Create, show, and list feature files
  In order to create and view new feature files
  As an public user
  I want to be able to create, show, and list new features

  Scenario: View the list of features
    Given there is feature titled "Some terse yet descriptive text of what is desired"
    When I go to "the list features page"
    And I should see "Some terse yet descriptive text of what is desired"

  Scenario: Create a new feature
    When I go to "the new feature page"
    And I fill in "feature_title" with "Some terse yet descriptive text of what is desired"
    And I fill in "scenario_title" with "Some determinable business situation"
    And I fill in "given_block" with "Given some precondition"
    And I fill in "when_block" with "When some action by the actor"
    And I fill in "then_block" with "Then some testable outcome is achieved"
    And I press "submit"
    Then I should be on "the list features page"
    And I should see "Some terse yet descriptive text of what is desired"

  Scenario: Add a new scenario to a existing feature
    Given there is feature titled "Some terse yet descriptive text of what is desired"
    When I go to "the list features page"
    And I follow "Some terse yet descriptive text of what is desired"
    And I follow "Add scenario"
    And I fill in "feature_title" with "Another terse yet descriptive text of what is desired"
    And I fill in "scenario_title" with "Another determinable business situation"
    And I fill in "given_block" with "Given another precondition"
    And I fill in "when_block" with "When some action by the actor"
    And I fill in "then_block" with "Then some testable outcome is achieved yet again"
    And I press "submit"
    Then I should be on "the show feature page"
    And I should see "Another determinable business situation"

  Scenario: View a single feature
    Given there is feature titled "Some terse yet descriptive text of what is desired"
    And the feature has "feature_title" of "Some terse yet descriptive text of what is desired"
    And the feature has "scenario_title" of "Some determinable business situation"
    And the feature has "given_block" of "Given another precondition"
    And the feature has "when_block" of "When some action by the actor"
    And the feature has "then_block" of "Then some testable outcome is achieved"
    When I go to "the list features page"
    And I follow "Some terse yet descriptive text of what is desired"
    Then I should see "Some terse yet descriptive text of what is desired"
    And I should see "Some determinable business situation"
    And I should see "Given another precondition"
    And I should see "When some action by the actor"
    And I should see "Then some testable outcome is achieved"

