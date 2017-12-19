@wip
Feature: Request creation
  Test request creation functionality

  Scenario: Create new request and request collection
    Given I login as regular user
    When I select an existing project
    And I create a request collection
    Then I create a "Login" request and save it to the collection
    And I delete all collections
