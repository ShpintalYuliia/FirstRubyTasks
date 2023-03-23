# google_translate.feature

Feature: Google Translate
  As a user of Google Translate
  I want to translate a word from English to Spanish
  So that I can communicate with Spanish speakers

  Scenario: Translate a word from English to Spanish
    Given I am on the Google Translate page
    When I enter the word "hello" into the input field
    And I select "English" as the source language
    And I select "Spanish" as the target language
    And I click the "Translate" button
    Then I should see the translated word "hola" on the page