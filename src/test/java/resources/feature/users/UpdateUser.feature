@UpdateUser
Feature: Actualizar Usuario

  Background:
    * url baseUrl
    * def dataGen = callonce read('classpath:resources/helpers/data-generator.js')
    * def user = dataGen
    * print 'Usuario generado para Update:', user

    # Crear usuario primero
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id
    * print 'Usuario creado con ID:', userId

  @smoke
  Scenario: Caso Positivo - Actualizar usuario existente
    * def randomEmail = 'updated_' + Math.floor(Math.random() * 100000) + '@test.com'
    * def updateRequest = read('classpath:resources/requests/update-user.json')
    Given path 'usuarios', userId
    And request updateRequest
    * print 'Request UpdateUser (positivo):', updateRequest
    When method put
    Then status 200
    And match response == { message: 'Registro alterado com sucesso' }
    * print 'Usuario actualizado con email:', randomEmail

  @negativo
  Scenario: Caso Negativo - Intentar actualizar con email ya existente de nuestra lista de Usuarios
    * def result = call read('classpath:resources/feature/users/ListUsers.feature')
    * def existingEmail = result.existingEmail
    * print 'Email existente tomado del ListUser:', existingEmail

    # Intentar actualizar con ese email
    * def duplicatedUser =
      """
      {
        "nome": "NombreActualizado",
        "email": "#(existingEmail)",
        "password": "65455321",
        "administrador": "true"
      }
      """
    Given path 'usuarios', userId
    And request duplicatedUser
    When method put
    Then status 400
    And match response == { message: 'Este email já está sendo usado' }