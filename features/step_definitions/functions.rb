def configure_connection_to_database
  @connection = Mysql2::Client.new(:host => "remotemysql.com",
                                   :username => "e1DOZmmbdj",
                                   :password => "5lYv85Ujh0",
                                   :database => "e1DOZmmbdj")
end

def log_in_db_successful(scenario, step)
  @connection.query("INSERT INTO AutotestLog (time, scenario, step, result, error) VALUES (now(), '#{scenario}', '#{step}', 'successful', NULL);")
end

def log_in_db_unsuccessful(scenario, step, error)
  @connection.query("INSERT INTO AutotestLog (time, scenario, step, result, error) VALUES (now(), '#{scenario}', '#{step}', 'unsuccessful', '#{error}');")
end

def sql_SELECT
  @connection.query("SELECT * FROM AutotestLog").each do |item|
    puts item
  end
end

