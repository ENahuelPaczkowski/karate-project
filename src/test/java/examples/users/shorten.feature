Feature: Shorten

  Background:
    * url 'https://url-shortener-service.p.rapidapi.com'
    Given path '/shorten'

  Scenario Outline: shorten '<titulo>'
    * header x-rapidapi-key = '<x-rapidapi-key>'
    * def body = read('classpath:<path>')
    And request body
    When method POST
    Then status <status>
    Then match <response>

    Examples:
      | titulo        | x-rapidapi-key                                     | path                                     | status | response                                                                |
      | exitoso       | 5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b | examples/users/request/body.json         | 200    | response.result_url == '#string'                                        |
      | invalid url   | 5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b | examples/users/request/invalid_url.json  | 400    | response ==  read('classpath:examples/users/response/invalid_url.json') |
      | sin body      | 5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b | examples/users/request/invalid_body.json | 400    | response ==  read('classpath:examples/users/response/error.json')       |
      | invalid Token | asdasdas                                           | examples/users/request/body.json         | 403    | response ==  read('classpath:examples/users/response/message.json')     |