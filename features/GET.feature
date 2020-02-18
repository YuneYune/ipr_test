# encoding: UTF-8
# language: ru

@rest
Функционал: REST. http://petstore.swagger.io

  @findByStatus @all
  Структура сценария: Запрос findByStatus с опр. статусом --> всех животных ТОЛЬКО с этим статусом
    * Послали GET 'https://petstore.swagger.io/v2/pet/findByStatus?status=<status>' запрос
    * Проверили, что http status code == 200
    * Проверили, что в ответе статус у всех животных == <status> GET запроса

    Примеры:
      | status    |
      | available |
      | pending   |
      | sold      |


  @create_an_animal @all
  Структура сценария: Зачистили id, под которым будем создавать животное --> Создали животное --> Нашли и проверили его
    * Удалили животное с id, которое будем добавлять, послав DELETE запрос на URL 'https://petstore.swagger.io/v2/pet/<id>'
    * Проверили, что status code == 200 или 404
    * Послали POST на URL 'https://petstore.swagger.io/v2/pet' с параметрами животного:
      | key    | value                                                       |
      | id     | <id>                                                        |
      | c_id   | 228                                                         |
      | c_name | flex                                                        |
      | name   | <name>                                                      |
      | ph_url | https://m.media-amazon.com/images/I/81rCvbYgMKL._SS500_.jpg |
      | t_id   | 1488                                                        |
      | t_name | wild                                                        |
      | status | available                                                   |
    * Проверили, что http status code == 200
    * Послали GET 'https://petstore.swagger.io/v2/pet/<id>' запрос
    * Убедились, что мы добавили животное, сравнив параметры POST и GET запросов

    Примеры:
      | id   | name   |
      | 228  | jiraf  |
      | 1488 | sobaka |
      | 2020 | koshka |

  @create_an_order @all
  Структура сценария: Зачистили id, под которым будем создавать заказ --> Создали заказ --> Нашли и проверили его
    * Удалили заказ с id, которое будем добавлять, послав DELETE запрос на URL 'https://petstore.swagger.io/v2/store/order/<id>'
    * Проверили, что status code == 200 или 404
    * Послали POST на URL 'https://petstore.swagger.io/v2/store/order' с параметрами заказа:
      | key      | value                    |
      | id       | <id>                     |
      | petId    | 228                      |
      | quantity | 100                      |
      | shipDate | 2020-08-15T20:20:20.671Z |
      | status   | <status>                 |
      | complete | false                    |
    * Проверили, что http status code == 200
    * Послали GET 'https://petstore.swagger.io/v2/store/order/<id>' запрос
    * Убедились, что мы добавили заказ, сравнив параметры POST и GET запросов

    Примеры:
      | id   | status    |
      | 228  | placed    |
      | 1488 | approved  |
      | 2020 | delivered |


  @update_an_animal @all
  Структура сценария: Обновление животного
    * Удалили животное с id, которое будем добавлять, послав DELETE запрос на URL 'https://petstore.swagger.io/v2/pet/1488'
    * Проверили, что status code == 200 или 404
    * Послали POST на URL 'https://petstore.swagger.io/v2/pet' с параметрами животного:
      | key    | value                                                       |
      | id     | 1488                                                        |
      | c_id   | 228                                                         |
      | c_name | flex                                                        |
      | name   | programmist                                                 |
      | ph_url | https://m.media-amazon.com/images/I/81rCvbYgMKL._SS500_.jpg |
      | t_id   | 1488                                                        |
      | t_name | wild                                                        |
      | status | available                                                   |
    * Проверили, что http status code == 200
    * Послали PUT на URL 'https://petstore.swagger.io/v2/pet/updatePet' с параметрами:
      | key    | value                                                       |
      | id     | 1488                                                        |
      | c_id   | 228                                                         |
      | c_name | flex                                                        |
      | name   | <name>                                                      |
      | ph_url | https://m.media-amazon.com/images/I/81rCvbYgMKL._SS500_.jpg |
      | t_id   | 1488                                                        |
      | t_name | wild                                                        |
      | status | <status>                                                    |
    * Послали GET 'https://petstore.swagger.io/v2/store/order/1488' запрос
    * Убедились, что мы обновили животное, сравнив параметры PUT и GET запросов

    Примеры:
      | name     | status    |
      | zmeya    | sold      |
      | tarantul | pending   |
      | pingvin  | available |


  @delete_an_animal @all
  Структура сценария: Создали животное --> Удалили животное --> Попытались найти удал. животное --> error
    * Послали POST на URL 'https://petstore.swagger.io/v2/pet' с параметрами животного:
      | key    | value                                                       |
      | id     | <id>                                                        |
      | c_id   | 228                                                         |
      | c_name | flex                                                        |
      | name   | <name>                                                      |
      | ph_url | https://m.media-amazon.com/images/I/81rCvbYgMKL._SS500_.jpg |
      | t_id   | 1488                                                        |
      | t_name | wild                                                        |
      | status | available                                                   |
    * Проверили, что http status code == 200
    * Послали DELETE 'https://petstore.swagger.io/v2/pet/<id>' запрос
    * Послали GET 'https://petstore.swagger.io/v2/pet/<id>' запрос
    * Проверили, что http status code == 404

    Примеры:
      | id   | name   |
      | 228  | jiraf  |
      | 1488 | sobaka |
      | 2020 | koshka |


  @delete_an_animal @all
  Структура сценария: Создали заказ --> Удалили заказ --> Попытались найти удал. заказ --> error
    * Послали POST на URL 'https://petstore.swagger.io/v2/store/order' с параметрами заказа:
      | key      | value                    |
      | id       | <id>                     |
      | petId    | 228                      |
      | quantity | 100                      |
      | shipDate | 2020-08-15T20:20:20.671Z |
      | status   | <status>                 |
      | complete | false                    |
    * Проверили, что http status code == 200
    * Послали DELETE 'https://petstore.swagger.io/v2/store/order/<id>' запрос
    * Послали GET 'https://petstore.swagger.io/v2/store/order/<id>' запрос
    * Проверили, что http status code == 404

    Примеры:
      | id   | status    |
      | 228  | placed    |
      | 1488 | approved  |
      | 2020 | delivered |

