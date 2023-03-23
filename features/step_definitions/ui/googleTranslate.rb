# google_translate_steps.rb

require 'selenium-webdriver'

Given("I am on the Google Translate page") do
  # @driver = Selenium::WebDriver.for :chrome
  @driver = Selenium::WebDriver.for :chrome
  @driver.navigate.to("https://www.saucedemo.com/")
end

When("I enter the word {string} into the input field") do |word|
  @driver.find_element(:id, 'source').send_keys word
end

And("I select {string} as the source language") do |language|
  dropdown = @driver.find_element(:xpath, '//div[@aria-label="Source language"]/div[@role="button"]')
  dropdown.click
  language_option = @driver.find_element(:xpath, "//span[contains(text(), '#{language}')]")
  language_option.click
end

And("I select {string} as the target language") do |language|
  dropdown = @driver.find_element(:xpath, '//div[@aria-label="Target language"]/div[@role="button"]')
  dropdown.click
  language_option = @driver.find_element(:xpath, "//span[contains(text(), '#{language}')]")
  language_option.click
end

And("I click the {string} button") do |button_text|
  button = @driver.find_element(:xpath, "//span[contains(text(), '#{button_text}')]")
  button.click
end

Then("I should see the translated word {string} on the page") do |translation|
  result = @driver.find_element(:id, 'result_box').text
  expect(result).to eq(translation)
  @driver.quit
end