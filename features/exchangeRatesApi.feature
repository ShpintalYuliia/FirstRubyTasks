Feature: Exchange Rates API
  As a user of the Exchange Rates API
  I want to be able to get exchange rates for different currencies
  So that I can use them in my application

  Scenario: Check GET/convert endpoint
    When client sends a GET request to convert from "EUR" to "UAH" with "5" amount
    Then check date in response
    Then the response status should be "200"

  Scenario: Check GET/fluctuation endpoint
    When client sends a GET request to check fluctuation in period from "2022-01-01" to "2022-02-02"
    Then the response status should be "200"

  Scenario: Check invalid token
    When user uses invalid token
    Then the response status should be "401"

  Scenario: Check invalid invalid params
    When user use invalid params
    Then the response status should be "400"

  Scenario: Check needed currency is present
    When search currency among all currencies
    Then check "AMD" currency in response