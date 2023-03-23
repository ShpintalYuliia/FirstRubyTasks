Feature: Login Functionality
  As a user of the Sauce Demo website
  I want to be able to login
  So that I can access my account and use the website

  Scenario: Login with valid credentials
    Given I am on the Sauce Demo login page
    When I enter valid credentials
    And I click the login button
    Then I should be logged in and see the inventory page

  Scenario: Login with invalid credentials
    Given I am on the Sauce Demo login page
    When I enter invalid credentials
    And I click the login button
    Then I should see an error message