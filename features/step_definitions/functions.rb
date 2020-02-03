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







# def recursion(obj) # Возвращает массив [ключ, значение, ключ, значение, ...] вне зависимости от вложенности принимаемого объекта
#   result = []
#   iter = lambda do |counter, acc|
#     if counter.class != Hash && counter.class != Array
#       acc.push(counter)
#     elsif counter.is_a?(Hash)
#       iter(counter.flatten, acc)
#     else
#       counter.each do |value|
#         iter(value, acc)
#       end
#     end
#   end
#   iter.call(obj, result)
#   result
# end
#
# # x = {'a': 1,
# #      'b': [2,3, {'c': 4, 't': 'cxz', 'fds': [1,2,3,4,5,6,7, {'rpid': 'id1'}]}, 5]
# # }
# #
# # recursion(x)
#
# def wait_while(timeout = 600, retry_interval = 20, &block)
#   puts
#   start = Time.now
#   while (result = !!block.call)
#     break if (Time.now - start).to_i >= timeout
#     sleep(retry_interval)
#   end
#   !result
# end