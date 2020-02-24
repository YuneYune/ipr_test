# encoding: utf-8
# frozen_string_literal: true


Before do |scenario|
  @counter = 0
  @scenarios_name = scenario.name
  configure_connection_to_database
end

AfterStep do |_result, step|
  @counter += 1
  steps_name = step.text
  log_in_db_successful(@scenarios_name, steps_name)
end

After do |scenario|
  if scenario.failed?
    error = scenario.exception
    arr_of_steps = scenario.test_steps.map(&:text).delete_if { |item| item.include? "hook" }
    arr_of_steps[@counter]
    log_in_db_unsuccessful(@scenarios_name, arr_of_steps[@counter], error)
  end
  # sql_SELECT
end


# Выполняется перед сценарием
Before('@ui') do
  remote_or_local
  set_page_timeouts
end

# Выполняется после сценария
After('@ui') do
  screenshot
  quit_browser
end