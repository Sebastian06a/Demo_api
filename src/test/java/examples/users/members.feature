#Pruebas de Members API

Feature: Members API Tests

  Background:
    * url 'http://localhost:3000'
    * def auth = call read('autor.js') { username: 'admin', password: 'admin' }
    * header Authorization = auth


  @get
  Scenario: Obtener todos los miembros debe devolver 200
    Given path 'api/members'
    When method GET
    Then status 200
    And match each response contains { id: '#number', name: '#string', gender: '#string' }

  @crud
  Scenario: Flujo completo de CRUD de miembros
  # Crear
    Given path 'api/members'
    And request { name: 'SebasQA', gender: 'Male' }
    When method POST
    Then status 200
    And match response != '#empty'
    * def memberId = response.id

  # Leer
    Given path 'api/members', memberId
    When method GET
    Then status 200
    And match response == { id: '#(memberId)', name: 'SebasQA', gender: 'Male' }

  # Actualizar
    Given path 'api/members', memberId
    And request { name: 'SebasQA Updated', gender: 'Male' }
    When method PUT
    Then status 200
    And match response.name == 'SebasQA Updated'

  # Eliminar
    Given path 'api/members', memberId
    When method DELETE
    Then status 200
    And match response != '#empty'


  @members
  Scenario: Obtener todos los miembros
    Given path 'api/members'
    When method GET
    Then status 200
    And match response == '#array'
    And match each response contains { id: '#number', name: '#string', gender: '#string' }


  @members
  Scenario: Filtrar miembros por género
    Given path 'api/members'
    And param gender = 'Female'
    When method GET
    Then status 200
    And match each response contains { gender: 'Female' }


  @members
  Scenario: Obtener miembro por ID
    Given path 'api/members/1'
    When method GET
    Then status 200
    And match response contains { id: 1 }

  @members
  Scenario: Crear nuevo miembro
    Given path 'api/members'
    And request { name: 'Test User', gender: 'Male' }
    When method POST
    Then status 201
    And match response contains { name: 'Test User' }

  @members
  Scenario: Actualizar miembro via PUT
    Given path 'api/members/1'
    And request { name: 'Updated Name', gender: 'Male' }
    When method PUT
    Then status 200
    And match response.name == 'Updated Name'

  @members
  Scenario: Actualizar parcialmente miembro via PATCH
    Given path 'api/members/1'
    And request { name: 'Patched Name' }
    When method PATCH
    Then status 200
    And match response.name == 'Patched Name'



  @members
  Scenario: Eliminar miembro
    Given path 'api/members/1'
    When method DELETE
    Then status 200
    And match response != '#empty'


