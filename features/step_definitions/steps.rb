# encoding: utf-8

require 'jsonpath'

When(/^Послали POST на URL "([^"]*)" с параметрами:$/) do |urn, table|
  payload_hash = {}
  headers_hash = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  table.hashes.each {|param| payload_hash = payload_hash.merge(Hash[param[:key], param[:value]])}
  payload_hash = payload_hash.to_json
  send_post(urn, payload_hash, headers_hash)
end


When(/Проверили, что в ответе значение параметра (.*) имеет длину (.*)/) do |param, length|
  arr_of_hashes = JSON.parse @last_response.body
  if arr_of_hashes.class == Array # ---> при GET запросе выдаёт массив словарей(отчётов)
    arr_of_hashes.flatten.each do |value|
      parametr = value["#{param}"]
      expect(parametr.length).to eq(length.to_i)
    end
  elsif arr_of_hashes.class == Hash # ---> при POST запросе выдаёт 1 словарь(отчёт), в котором только "rpid"
    expect(arr_of_hashes["#{param}"].length).to eq(length.to_i)
  else
    raise 'Втираешь какую-то дичь'
  end
end

When(/Проверили, что параметр (.*) соответствует названию (.*)/) do |reportType, name|
  arr_of_hashes = JSON.parse @last_response.body
  arr_of_hashes.each do |value|
    expect(value["#{reportType}"]).to eq(value["#{name}"])
  end
end

When(/Проверили, что http status code == (\d*)/) do |code|
  expect(code).to eq(@last_response.code.to_s)
end

When(/Проверили, что статус ошибки (.*) соответствует названию ошибки (.*)/) do |status_code, error|
  arr_of_hashes = JSON.parse @last_response.body
  errors = arr_of_hashes["errors"][0]
  code_of_error = errors["code"]
  status_of_error = errors["status"]
  expect(status_code.to_i).to eq(status_of_error)
  expect(error).to eq(code_of_error)
end

When(/^Послали GET '([^"]*)' запрос$/) do |url|
  @response = send_get url
  log_response_params @last_response.code, @last_response.headers, @last_response.body
  @last_response = @response
  puts @response
end

When(/Запомнили значение параметра (.*), который получили после POST запроса/) do |param|
  arr_of_hashes = JSON.parse @last_response.body
  @value_to_remember = arr_of_hashes["#{param}"]
end

When(/Сверили значение полученного параметра (.*) с запомненным/) do |param|
  step "Находим значение ключа #{param} и сравниваем с #{@value_to_remember}"
end

When(/Убедились, что мы НЕ нашли в GET запросе наше запомненное значение (.*)/) do |param|
  path = JsonPath.new("$..#{param}")
  arr_of_values = path.on(@last_response.body)
  expect(arr_of_values).not_to include @value_to_remember
end

When(/Находим значение ключа (.*) и сравниваем с (.*)/) do |key, value|
  path = JsonPath.new("$..#{key}")
  arr_of_values = path.on(@last_response.body)
  expect(arr_of_values).to include value
end

When(/Сверили запомненное значение со значением параметра - (.*) из SQL таблицы (.*)/) do |param, sql_table|
  step "Инициализировали sql подключение"
  step "Настроили параметры подключения к ALFAMOSU"
  step "SQL: SELECT * FROM afilb01.#{sql_table} WHERE #{sql_table[0,3].upcase}#{param.upcase} = '#{@value_to_remember}'"
  @sql = sql_table
  @parametr = param
  expect(@sql_to_remember[0]["#{sql_table[0,3].upcase}#{param.upcase}"]).to eq(@value_to_remember)
end

When(/Проверили, что поле (.*) записи в SQL таблице (.*) == (.*)/) do |name, sql_table, value|
  expect(@sql_to_remember[0]["#{sql_table[0,3].upcase}#{name.upcase}"]).to eq(value)
end

When(/Пытаемся скачать отчёт по запомненному (.*) пользователем с USID - (.*), ORID - (.*), у которого недостаточно прав/) do |rpid, usid, orid|
  step "Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/#{@value_to_remember}/download?usid=#{usid}&orid=#{orid}' запрос"
end

When(/Ждём (.*) минут, или пока поле (.*) в SQL таблице (.*) станет (.*)/) do |minute, param, sql_table, value|
  step "Инициализировали sql подключение"
  step "Настроили параметры подключения к ALFAMOSU"
  wait_while(minute.to_i * 60, 10) do
    step "SQL: SELECT * FROM afilb01.#{sql_table} WHERE #{sql_table[0,3].upcase}#{@parametr.upcase} = '#{@value_to_remember}'"
    @sql_to_remember[0]["#{sql_table[0,3].upcase}#{param.upcase}"] != value
  end
  expect(@sql_to_remember[0]["#{sql_table[0,3].upcase}#{param.upcase}"]).to eq(value)
end

When(/Делаем составной SQL запрос/) do
  str = ""
  step "SQL: #{str}"
end

When(/Удостоверились, что мы получили ошибку - (.*)/) do |error|
  path = JsonPath.new("$..jexceptionMsg")
  arr_of_values = path.on(@last_response.body)
  expect(arr_of_values[0]).to match /.*#{error}/
end