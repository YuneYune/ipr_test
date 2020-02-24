# encoding: UTF-8
# language: ru


When(/^Открыли - ([^"]*)$/) do |url|
  puts "navigate:#{url}"
  @browser.navigate.to url
end