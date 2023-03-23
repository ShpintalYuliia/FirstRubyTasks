include Test::Unit::Assertions
base_uri = "https://petstore.swagger.io/v2"
$pet_id = nil

When(/^client sends POST request to add new pet$/) do
  url = URI('https://petstore.swagger.io/v2/pet')
  payload = {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = payload.to_json

  $response = http.request(request)
  $pet_id = JSON.parse($response.body)["id"]
  #binding.pry
  puts $pet_id
  #puts $response.read_body
end

When(/^client sends PUT request to change pet's name "(.*)"$/) do |name|
  url = URI("https://petstore.swagger.io/v2/pet")

  payload = {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "#{name}",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true # Uncomment this line if you're using HTTPS

  request = Net::HTTP::Put.new(url)
  request["Content-Type"] = "application/json"
  request.body = payload.to_json

  $response = http.request(request)
  # puts $response.read_body
end

When(/^client want to delete pet by id$/) do
  puts $pet_id
  url = URI("#{base_uri}/pet/#{$pet_id}")

  $response = HTTParty.delete(url)
end