# encoding: UTF-8
# language: ru


When(/^Открыли - ([^"]*)$/) do |url|
  puts "navigate:#{url}"
  @browser.navigate.to url
end

When(/^Дождались загрузки - ([^"]*)$/) do |locator|
  puts 'wait ' + locator
  element = @browser.find_element(:xpath, locator)
  puts element
  begin
    element if element.displayed? && element.enabled?
    puts 'element has appeared'
  rescue Selenium::WebDriver::Error::TimeoutError => e
    puts "caught exception #{e}! ohnoes!"
  end
end