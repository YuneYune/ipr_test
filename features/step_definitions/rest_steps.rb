# encoding: utf-8

require 'jsonpath'

When(/^Послали POST на URL "([^"]*)" с параметрами (.*):$/) do |urn, type, table|
  if type == 'животного' # создаём животное
    variables = table.raw.flatten
    payload_hash = {
        "id": "#{variables[3]}".to_i,
        "category": {
            "id": "#{variables[5]}".to_i,
            "name": "#{variables[7]}"
        },
        "name": "#{variables[9]}",
        "photoUrls": [
            "#{variables[11]}"
        ],
        "tags": [
            {
                "id": "#{variables[13]}".to_i,
                "name": "#{variables[15]}"
            }
        ],
        "status": "#{variables[17]}"
    }
    payload_hash = payload_hash.to_json
  else # создаём заказ
    variables = table.raw.flatten
    payload_hash = {
        "id": "#{variables[3]}".to_i,
        "petId": "#{variables[5]}".to_i,
        "quantity": "#{variables[7]}".to_i,
        "shipDate": "#{variables[9]}",
        "status": "#{variables[11]}",
        "complete": (!!"#{variables[13]}")
    }
    payload_hash = payload_hash.to_json
  end
  headers_hash = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  send_post(urn, payload_hash, headers_hash)
  @requests_payload = payload_hash #json
end

When(/^Послали PUT на URL "([^"]*)" с параметрами:$/) do |urn, table|
  variables = table.raw.flatten
  payload_hash = {
      "id": "#{variables[3]}".to_i,
      "category": {
          "id": "#{variables[5]}".to_i,
          "name": "#{variables[7]}"
      },
      "name": "#{variables[9]}",
      "photoUrls": [
          "#{variables[11]}"
      ],
      "tags": [
          {
              "id": "#{variables[13]}".to_i,
              "name": "#{variables[15]}"
          }
      ],
      "status": "#{variables[17]}"
  }
  headers_hash = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  payload_hash = payload_hash.to_json
  send_put(urn, payload_hash, headers_hash)
  @requests_payload = payload_hash #json
  puts @last_response.code
end

When(/^Послали DELETE "([^"]*)" запрос$/) do |url|
  @response = send_delete url
  log_response_params @last_response.code, @last_response.headers, @last_response.body
  @last_response = @response
end

When(/^Удалили (.*) с id, которое будем добавлять, послав DELETE запрос на URL "(.*)"$/) do |unnecessary, url|
  headers_hash = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  send_delete(url, headers_hash)
end

When(/^Убедились, что мы (.*) (.*), сравнив параметры (.*) и (.*) запросов$/) do |verb, type, meth1, meth2|
  @last_response = @last_response.body
  if type == 'заказ'
    @requests_payload = JSON.parse @requests_payload
    @last_response = JSON.parse @last_response
    @requests_payload.delete('shipDate')
    @last_response.delete('shipDate')
  end
  expect(@last_response == @requests_payload).to be true
end

When(/^Убедились, что мы удалили (.*)$/) do |type|
  expect(@last_response.code).to eq(404)
end


When(/Проверили, что в ответе статус у всех животных == (.*) GET запроса/) do |get_status|
  arr_of_statuses = ['sold', 'pending', 'available']
  arr_of_statuses.delete(get_status)
  arr_of_hashes = JSON.parse @last_response.body
  result_arr = []
  arr_of_hashes.each do |value|
    result_arr.push(value['status'])
  end
  # puts result_arr
  # puts arr_of_statuses
  arr_of_statuses.each do |value| #именно так, потому что по-другому походу кукумбер слишком быстро делает запросы, и в статусе жимотоного проскакивает nil
    expect(result_arr).to_not include(value)
  end
end

When(/^Проверили, что http status code == (\d*)$/) do |code|
  expect(@last_response.code.to_s).to eq(code)
end

When(/^Проверили, что status code == (\d*) или (\d*)$/) do |code1, code2|
  expect(@last_response.code.to_s).to eq(code1).or eq(code2)
end


When(/^Послали GET "(.*)" запрос$/) do |url|
  @response = send_get url
  # log_response_params @last_response.code, @last_response.headers, @last_response.body
  @last_response = @response
end

