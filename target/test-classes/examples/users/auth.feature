#Pruebas de Autenticación

Feature: Authentication Tests

  Background:
    * url 'http://localhost:3000'
    * def auth = call read('autor.js') { username: 'admin', password: 'admin' }
    * header Authorization = auth

  @auth
  Scenario: Probar credenciales inválidas
    Given path 'api/members'
    And header Authorization = call read('autor.js') { username: 'wrong', password: 'wrong' }
    When method GET
    Then status 401
    And match response == '#notEmpty'

  @auth
  Scenario: Probar autenticación faltante
    Given path 'api/members'
    When method GET
    Then status 401
    And match response != '#empty'

  @auth
  Scenario: Probar credenciales válidas
    Given path 'api/members'
    And header Authorization = call read('autor.js') { username: 'admin', password: 'admin' }
    When method GET
    Then status 200
    