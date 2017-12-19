@wip
Feature: Project management sidebar feature
  Test project management features

  Scenario: Create a project with 2 environments and variables then delete both environments
    Given I login as regular user
    When I create a project
    And I create these environments:
    | Environment name |
    | PROD             |
    | DEV              |
    And I create global variables for "PROD" environment:
    | key      | value    |
    | $user    | prodUser |
    | $pwd     | prodPwd  |
    And I create global variables for "DEV" environment:
    | key      | value   |
    | $user    | devUser |
    | $pwd     | devPwd  |
    Then I check if these variables are created for "PROD" environment:
    | key      | value    |
    | $user    | prodUser |
    | $pwd     | prodPwd  |
    Then I check if these variables are created for "DEV" environment:
    | key      | value   |
    | $user    | devUser |
    | $pwd     | devPwd  |
    And I delete all environments
    And I check that no environment is in the project


