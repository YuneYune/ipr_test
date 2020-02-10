# encoding: UTF-8
# language: ru
@rest
Функционал: REST. http://petstore.swagger.io/#/pet/

  @assa
  Структура сценария: Запрос findByStatus с опр. статусом --> всех животных ТОЛЬКО с этим статусом
    * Послали GET 'http://petstore.swagger.io/#/pet/findByStatus?status=<status>' запрос
#    * Проверили, что http status code == 200
#    * Проверили, что параметр <reportType> соответствует названию <name>

    Примеры:
      | status    |
      | available |
      | pending   |
      | sold      |

  @get2 @sleep5
  Структура сценария: GET запрос без reportType --> status code == 200
    * Послали GET 'http://ufrmspr1/ufr-azon-reports-api/reports/?orid=000AJN&usid=0000000I0L&reportType=<reportType>' запрос
    * Проверили, что http status code == 200

    Примеры:
      | reportType |
      |            |


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