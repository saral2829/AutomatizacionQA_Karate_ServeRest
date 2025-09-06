@DeleteUser
Feature:Eliminar Usuario

  Background:
    * url baseUrl
    * def user = call read('classpath:resources/helpers/data-generator.js')
    * print 'Usuario generado para Delete:', user

    # Crear usuario primero
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    * def userId = response._id
    * print 'Usuario creado con ID:', userId

  @smoke
  Scenario: Caso Positivo - Eliminar usuario existente
    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response == { message: 'Registro excluído com sucesso' }
    * print 'Usuario eliminado con ID:', userId

  @negativo
  Scenario: Caso Negativo - Intentar eliminar un usuario inexistente
    * def fakeId = java.lang.Math.abs(new java.util.Random().nextLong()).toString().substring(0,16)
    Given path 'usuarios', fakeId
    When method delete
    Then status 200
    And match response == { message: 'Nenhum registro excluído' }
    * print 'Intento de eliminar con ID inválido:', fakeId