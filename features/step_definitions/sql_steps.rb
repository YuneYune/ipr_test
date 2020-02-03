# frozen_string_literal: true

require 'drb'
require 'json'

# запуск drb
Given('Инициализировали sql подключение') do
  $drb_server = 'druby://capacity:9900' # штатный
  DRb.start_service
  $cucu = DRbObject.new_with_uri($drb_server)
end

# параметры подключения к БД
# http://confluence.moscow.alfaintra.net/pages/viewpage.action?pageId=92290644
Given('Настроили параметры подключения к ALFAMOSU') do
  $conn = {
      driver: 'DB2',
      url: 'jdbc:as400://ALFAMOSU;naming=sql;errors=full;date format=iso;extended dynamic=true;package=secPkg;package cache=true;cursor hold=true;blocksize=512;',
      login: 'AMWY',
      pass: 'AMWY11111',
      cruid: true
  }
end

# запрос к БД, который можно использовать до или после сценария
Given(/^SQL: (.*)$/) do |sql_string|
  # получаем результат выполнения запроса (результат искусственно ограничен 1000 строками)
  @sql_response = $cucu.sql_select($conn, sql_string)  ## JSON строка - массив
  arr = JSON.parse @sql_response               ## превретил в массив
  i = 0
  # распечатал результат
  arr.each do |r|
    p i += 1
    p r
  end
  @sql_to_remember = arr
end
