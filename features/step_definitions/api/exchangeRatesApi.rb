include Test::Unit::Assertions
$token = "ueYzxj0yOxy0hN3M8GC52IuW5bm0L5Q4"
$baseUri = "https://api.apilayer.com/exchangerates_data"
$response = nil

When(/^client sends a GET request to convert from "(.*)" to "(.*)" with "(.*)" amount$/) do |from, to, amount|
  url = URI("#{$baseUri}/convert?to=#{to}&from=#{from}&amount=#{amount}")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = $token

  $response = https.request(request)
  puts $response.read_body
end

When(/^client sends a GET request to check fluctuation in period from "(.*)" to "(.*)"$/) do |start_date, end_date|
  url = URI("#{$baseUri}/fluctuation?start_date=#{start_date}&end_date=#{end_date}")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = $token

  $response = https.request(request)
  puts $response.read_body
end

When(/^user uses invalid token$/) do
  url = URI("#{$baseUri}/convert?to=UAH&from=EUR&amount=3")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  #invalid apikey
  request['apikey'] = "blablabla123"

  $response = https.request(request)
  puts $response.read_body
end

When(/^user use invalid params$/) do
  invalid_param = "LLL"
  url = URI("#{$baseUri}/convert?to=#{invalid_param}&from=EUR&amount=3")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = $token

  $response = https.request(request)
  puts $response.read_body
end

When(/^search currency among all currencies$/) do
  url = URI("#{$baseUri}/symbols")

  https = Net::HTTP.new(url.host, url.port);
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['apikey'] = $token

  $response = https.request(request)
  puts $response.read_body
end

Then(/^the response status should be "(.*)"$/) do |code|
  assert_equal(code, $response.code.to_s, "Status Code Not #{code}")
end

Then(/^check date in response$/) do
  parsed_json = JSON.parse($response.body)
  puts parsed_json
  current_date = Date.today.to_s
  #current_date = "2023-03-22"
  assert_equal(current_date, parsed_json["date"], "Date is not #{current_date}")
end

Then(/^check "(.*)" currency in response$/) do |currency|
  parsed_json = JSON.parse($response.body)
  hash = parsed_json["symbols"]
  assert_true(hash.key?(currency), "There is no such currency like #{currency}")
end