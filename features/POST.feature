# encoding: UTF-8
# language: ru
@rest
Функционал: API. POST запросы ufr-azon-reports-api/reports


  @post1 @sleep5
  Структура сценария: POST запрос с валидным "type" --> status code == 200
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value      |
      | orid         | 000AJN     |
      | usid         | 0000000I0L |
      | channel      | AZON       |
      | type         | <type>     |
      | employeeType | E          |
    * Проверили, что http status code == 200
    * Проверили, что в ответе значение параметра rpid имеет длину 10

    Примеры:
      | type |
      | R00A |
      | R00B |
      | R00E |


  @post2 @sleep5
  Структура сценария: POST запрос с валидным "employeeType" --> status code == 200
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value          |
      | orid         | 000AJN         |
      | usid         | 0000000I0L     |
      | channel      | AZON           |
      | type         | R00A           |
      | employeeType | <employeeType> |
    * Проверили, что http status code == 200
    * Проверили, что в ответе значение параметра rpid имеет длину 10

    Примеры:
      | employeeType |
      | E            |
      | F            |
      | N            |
      | D            |


  @post3 @sleep5
  Структура сценария: POST запрос с валидным "channel" --> status code == 200
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value      |
      | orid         | 000AJN     |
      | usid         | 0000000I0L |
      | channel      | <channel>  |
      | type         | R00A       |
      | employeeType | E          |
    * Проверили, что http status code == 200
    * Проверили, что в ответе значение параметра rpid имеет длину 10

    Примеры:
      | channel |
      | AZON    |
  #      | PARTNER | ---> Нужны конкретные параметры запроса (орид, усид, тайп)


  @post4 @sleep5
  Структура сценария: POST запрос с невалидным "orid" --> status code == 500
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value      |
      | orid         | <orid>     |
      | usid         | 0000000I0L |
      | channel      | AZON       |
      | type         | R00A       |
      | employeeType | E          |
    * Проверили, что статус ошибки 500 соответствует названию ошибки internalError


    Примеры: # valid = 000AJN
      | orid    |
      | 000AJN0 |
      | 000AJN= |
      | 000AJNN |


  @post5 @sleep5
  Структура сценария: POST запрос с невалидным "usid" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value          |
      | orid         | 000AJN         |
      | usid         | <usid>         |
      | channel      | AZON           |
      | type         | R00A           |
      | employeeType | <employeeType> |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


    Примеры: # valid = 0000000I0L
      | usid        |
      | 0000000I0L0 |
      | 0000000I0L= |
      | 0000000I0LL |


  @post6 @sleep5
  Структура сценария: POST запрос с невалидным "channel" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value          |
      | orid         | 000AJN         |
      | usid         | 0000000I0L     |
      | channel      | <channel>      |
      | type         | R00A           |
      | employeeType | <employeeType> |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


    Примеры: # valid = PARTNER, AZON
      | channel  |
      | PARTNER! |
      | AZON0    |
      | =!!!     |
      | 5555     |
      | PARTNE   |
      | AZO      |


  @post7 @sleep5
  Структура сценария: POST запрос с невалидным "type" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value          |
      | orid         | 000AJN         |
      | usid         | 0000000I0L     |
      | channel      | AZON           |
      | type         | <type>         |
      | employeeType | <employeeType> |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


    Примеры: # valid = R00A, R00B, R00E, R00R, R00D, RPPR, RPRC
      | type  |
      | R00   |
      | R00AA |
      | R00=  |
      | !=-!  |


  @post8 @sleep5 @ZPFL1-2696
  Структура сценария: POST запрос с невалидным "employeeType" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value          |
      | orid         | 000AJN         |
      | usid         | 0000000I0L     |
      | channel      | AZON           |
      | type         | R00A           |
      | employeeType | <employeeType> |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


    Примеры: # valid = D, F, N, E
      | employeeType |
      | 0            |
      | =            |
      | Z            |
      | DD           |


  @post9 @sleep5
  Структура сценария: POST запрос с пустыми "orid", "usid", "channel", "type", "employeeType" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value          |
      | orid         | <orid>         |
      | usid         | <usid>         |
      | channel      | <channel>      |
      | type         | <type>         |
      | employeeType | <employeeType> |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


    Примеры:
      | orid   | usid       | channel | type | employeeType |
      | 000AJV | 0000000I0L | AZON    | R00A |              |
      | 000AJV | 0000000I0L | AZON    |      | E            |
      | 000AJV | 0000000I0L |         | R00A | E            |
      | 000AJV |            | AZON    | R00A | E            |
      |        | 0000000I0L | AZON    | R00A | E            |


  @post10 @sleep5
  Сценарий: POST запрос без параметра "orid" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value      |
      | usid         | 0000000I0L |
      | channel      | AZON       |
      | type         | R00A       |
      | employeeType | E          |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


  @post11 @sleep5
  Сценарий: POST запрос без параметра "usid" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value  |
      | orid         | 000AJN |
      | channel      | AZON   |
      | type         | R00A   |
      | employeeType | E      |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


  @post12 @sleep5
  Сценарий: POST запрос без параметра "channel" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value      |
      | orid         | 000AJN     |
      | usid         | 0000000I0L |
      | type         | R00A       |
      | employeeType | E          |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


  @post13 @sleep5
  Сценарий: POST запрос без параметра "type" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key          | value      |
      | orid         | 000AJN     |
      | usid         | 0000000I0L |
      | channel      | AZON       |
      | employeeType | E          |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError


  @post14 @sleep5 @ZPFL1-2723
  Сценарий: POST запрос без параметра "employeeType" --> status code == 400
    * Послали POST на URL "http://ufrmspr1/ufr-azon-reports-api/reports/" с параметрами:
      | key     | value      |
      | orid    | 000AJN     |
      | usid    | 0000000I0L |
      | channel | AZON       |
      | type    | R00A       |
    * Проверили, что статус ошибки 400 соответствует названию ошибки validationError

