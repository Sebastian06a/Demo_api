#Pruebas de Upload/Download

Feature: File Operations

  Background:
    * url 'http://localhost:3000'
    * def auth = call read('autor.js') { username: 'admin', password: 'admin' }
    * header Authorization = auth

  @files
  Scenario: Subir y descargar archivo
  # Subir
    Given path 'api/upload'
    And multipart field name = 'Payasito.jpg'
    When method POST
    Then status 201
    And match response = 'Payasito.jpg'

  # Descargar
    Given path 'api/download?'
    And param name = 'Payasito.jpg'
    When method GET
    Then status 200
    And match response.name = 'Payasito.jpg'


  @files
  Scenario: Subir archivo
    Given path 'api/upload'
    And multipart file file = { read: 'Payasito.jpg', filename: 'Payasito.jpg' }
    And multipart field name = 'Payasito.jpg'
    When method POST
    Then status 201
    And match response != '#empty'

  @files
  Scenario: Descargar archivo
    Given path 'api/download?'
    And param name = 'Payasito.jpg'
    When method GET
    Then status 200
    And match response != '#empty'