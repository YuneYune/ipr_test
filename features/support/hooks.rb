# encoding: utf-8
# frozen_string_literal: true


Before('@rest') do |scenario|
  @counter = 0
  @scenarios_name = scenario.name
  if ENV["DbLogEnable"] == 'true'
    configure_connection_to_database
  end
end

AfterStep('@rest') do |_result, step|
  @counter += 1
  steps_name = step.text
  if ENV["DbLogEnable"] == 'true'
    log_in_db_successful(@scenarios_name, steps_name)
  end
end

After('@rest') do |scenario|
  if scenario.failed?
    error = scenario.exception
    arr_of_steps = scenario.test_steps.map(&:text).delete_if { |item| item.include? "hook" }
    arr_of_steps[@counter]
    if ENV["DbLogEnable"] == 'true'
      log_in_db_unsuccessful(@scenarios_name, arr_of_steps[@counter], error)
    end
  end
  # sql_SELECT
end


# Выполняется перед сценарием
Before('@ui') do
  Selenium::WebDriver::Chrome::Service.driver_path = "chromedriver.exe"
  absolute_path = get_filepath('features/support/utils/GoogleChromePortable/App/Chrome-bin/chrome.exe')
  options = Selenium::WebDriver::Chrome::Options.new(binary: "#{absolute_path}")
  @browser = Selenium::WebDriver.for(:chrome, options: options)
  target_size = Selenium::WebDriver::Dimension.new(1600, 1080)
  @browser.manage.window.size = target_size
  set_page_timeouts
end

# Выполняется после сценария
After('@ui') do |scenario|
  if scenario.failed?
    screenshot
  end
  quit_browser
end