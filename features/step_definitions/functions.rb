def recursion(obj) # Возвращает массив [ключ, значение, ключ, значение, ...] вне зависимости от вложенности принимаемого объекта
  result = []

  def iter(counter, acc)
    if counter.class != Hash && counter.class != Array
      acc.push(counter)
    elsif counter.is_a?(Hash)
      iter(counter.flatten, acc)
    else
      counter.each do |value|
        iter(value, acc)
      end
    end
  end

  iter(obj, result)
  result
end

def wait_while(timeout = 600, retry_interval = 20, *args, &block)
  start = Time.now
  while (result = !!block.call)
    break if (Time.now - start).to_i >= timeout
    sleep(retry_interval)
  end
  !result
end

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

