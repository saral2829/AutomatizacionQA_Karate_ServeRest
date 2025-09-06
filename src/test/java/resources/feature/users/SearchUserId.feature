@SearchUserId
Feature:Buscar usuario por ID

  Background:
    * url baseUrl
    * def user = call read('classpath:resources/helpers/data-generator.js')
    * print 'Usuario generado para Get:', user

    # Crear usuario primero
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id
    * print 'Usuario creado con ID:', userId

  @smoke
  Scenario: Caso Positivo - Buscar un usuario existente por ID
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response ==
      """
      {
        "nome": "#string",
        "email": "#string",
        "password": "#string",
        "administrador": "#string",
        "_id": "#(userId)"
      }
      """
    * print 'Usuario encontrado:', response

  @negativo
  Scenario: Caso Negativo - Buscar un usuario con ID inexistente
    * def errorId = (('' + Math.random()).substring(2) + ('' + Math.random()).substring(2)).substring(0,16)
    * print 'ID Inexistente:', errorId, 'len:', errorId.length
    Given path 'usuarios', errorId
    When method get
    Then status 400
    And match response == { message: 'Usuário não encontrado' }
    * print 'Intento fallido con ID inválido:', errorId