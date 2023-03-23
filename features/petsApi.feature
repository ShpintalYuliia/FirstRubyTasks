Feature: Pets API

  Scenario: Add a new pet to the store
    When client sends POST request to add new pet
    Then the response status should be "200"

  Scenario: Change pets name
    When client sends PUT request to change pet's name "Chap"
    Then the response status should be "200"

  Scenario: Delete pet by id
    When client want to delete pet by id
    Then the response status should be "200"