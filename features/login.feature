Feature: Login feature
  Test login functionality for Apimation

  Scenario: Positive login
    When I login as regular user
    Then I check if I am logged in and I can access my personal information

  Scenario: Negative login
    When I try to login with wrong password
    Then I check if I am not logged in and I can access my personal information