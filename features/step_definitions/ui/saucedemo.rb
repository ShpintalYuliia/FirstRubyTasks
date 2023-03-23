require 'selenium-webdriver'

Given("I am on the Sauce Demo login page") do
  @driver = Selenium::WebDriver.for :chrome
  @driver.navigate.to "https://www.saucedemo.com/"
end

When("I enter valid credentials") do
  @driver.find_element(:id, 'user-name').send_keys 'standard_user'
  @driver.find_element(:id, 'password').send_keys 'secret_sauce'
end

When("I enter invalid credentials") do
  @driver.find_element(:id, 'user-name').send_keys 'invalid_user'
  @driver.find_element(:id, 'password').send_keys 'invalid_password'
end

And("I click the login button") do
  @driver.find_element(:id, 'login-button').click
end

Then("I should be logged in and see the inventory page") do
  inventory_title = @driver.find_element(:class, 'title').text
  expect(inventory_title).to eq('Products')
  @driver.quit
end

Then("I should see an error message") do
  error_message = @driver.find_element(:xpath, '//h3').text
  expect(error_message).to eq('Epic sadface: Username and password do not match any user in this service')
  @driver.quit
end