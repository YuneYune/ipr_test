# encoding: UTF-8
# language: ru

@rest
Функционал: REST. http://petstore.swagger.io

  @findByStatus
  Структура сценария: Запрос findByStatus с опр. статусом --> всех животных ТОЛЬКО с этим статусом
    * Послали GET 'https://petstore.swagger.io/v2/pet/findByStatus?status=<status>' запрос
    * Проверили, что http status code == 200
    * Проверили, что в ответе статус у всех животных == <status> GET запроса

    Примеры:
      | status    |
      | available |
      | pending   |
      | sold      |


  @create_an_animal
  Структура сценария: Создание животного
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

  @create_an_order
  Структура сценария: Создание заказа
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


  @get3 @sleep5
  Структура сценария: GET запрос --> получил валидную длинну параметров
    * Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/?orid=000AJN&usid=0000000I0L&reportType=R00A' запрос
    * Проверили, что http status code == 200
    * Проверили, что в ответе значение параметра <param> имеет длину <length>

    Примеры:
      | param | length |
      | rpid  | 10     |
      | type  | 4      |


  @get4 @sleep5
  Структура сценария: GET запрос с невалидным "orid" --> status code == 500
    * Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/?orid=<orid>&usid=0000000I0L&reportType=R00A' запрос
    * Проверили, что статус ошибки 500 соответствует названию ошибки internalError

    Примеры:
      | orid     |
      | 000AJ    |
      | 000A     |
      | 000AJNg  |
      | 000AJNkk |
      | 000AJN0  |
      | 000AJN55 |
      | 000AJN-  |
      | 000AJN-- |

  @get5 @sleep5 @ZPFL1-2722
  Структура сценария: GET запрос с невалидным "usid" --> status code == 500
    * Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/?orid=000AJN&usid=<usid>&reportType=R00A' запрос
    * Проверили, что статус ошибки 500 соответствует названию ошибки internalError

    Примеры:
      | usid        |
      | 0000000I0   |
      | 0000000I    |
      | 0000000I0Ll |
      | 0000000I0L- |


  @get6 @sleep5
  Структура сценария: GET запрос с невалидным "reportType" --> status code == 400
    * Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/?orid=000AJN&usid=0000000I0L&reportType=<reportType>' запрос
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError

    Примеры:
      | reportType |
      | R00AA      |
      | R000       |
      | R002       |
      | R00A1      |
      | R00        |
      | R00a       |
      | R00z       |
      | R00A-      |
      | R00-       |


  @get7 @sleep5 @ZPFL1-2693 @ZPFL1-2692
  Структура сценария: GET запрос с пустыми "orid" и/или "usid" --> status code == 500
    * Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/?orid=<orid>&usid=<usid>&reportType=R00A' запрос
    * Проверили, что статус ошибки 500 соответствует названию ошибки internalError

    Примеры:
      | orid   | usid       |
      |        | 0000000I0L |
      | 000AJN |            |
      |        |            |


  @get8 @sleep5
  Структура сценария: GET запрос без указания параметров --> status code == 500
    * Послали GET '<url>' запрос
    * Проверили, что статус ошибки 500 соответствует названию ошибки internalError

    Примеры:
      | url                                                                           |
      | http://ufrmspr1/ufr-azon-reports-api/reports/?orid=000AJN&reportType=R00A     |
      | http://ufrmspr1/ufr-azon-reports-api/reports/?usid=0000000I0L&reportType=R00A |
      | http://ufrmspr1/ufr-azon-reports-api/reports/?orid=000AJN                     |
      | http://ufrmspr1/ufr-azon-reports-api/reports/?usid=0000000I0L                 |
      | http://ufrmspr1/ufr-azon-reports-api/reports/?reportType=R00A                 |
      | http://ufrmspr1/ufr-azon-reports-api/reports/?                                |
      | http://ufrmspr1/ufr-azon-reports-api/reports/                                 |