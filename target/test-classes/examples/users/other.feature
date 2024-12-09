#Headers y Delayed Response

Feature: Other API Features

  Background:
    * url 'http://localhost:3000'
    * def auth = call read('autor.js') { username: 'admin', password: 'admin' }
    * header Authorization = auth

  @headers
  Scenario: Probar requisito de encabezado obligatorio
    Given path 'api/sendheader'
    And header ChannelName = 'qa box lets test'
    When method GET
    Then status 200
    And match response != '#empty'

  @delay
  Scenario: Probar respuesta retrasada
    Given path 'api/lag'
    And param delay = 2000
    When method GET
    Then status 200
    And assert responseTime >= 2000

  @header
  Scenario: Probar requisito de encabezado
    Given path 'api/sendheader'
    And header channelName = 'qa box lets test'
    When method GET
    Then status 200
    And match response != '#empty'


  @delay
  Scenario: Probar respuesta retrasada
    Given path 'api/lag'
    And param delay = 3000
    When method GET
    Then status 200
    And assert responseTime >= 3000


  @vehicles
  Scenario: Obtener todos los vehículos
    Given path 'api/vehicles'
    When method GET
    Then status 200
    And match response == '#array'


  @authors
  Scenario: Obtener todos los autores
    Given path 'api/authors'
    When method GET
    Then status 200
    And match response == '#array'