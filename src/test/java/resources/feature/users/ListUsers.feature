@ListUsers
Feature:Listar Usuarios

  Background:
    * url baseUrl

  @smoke
  Scenario:Obtener lista de usuarios
    Given path 'usuarios'
    When method get
    Then status 200
    * print 'Lista de usuarios:', response.usuarios
    * def firstUser = response.usuarios[0]
    * def firstEmail = firstUser.email
    * print 'Email existente tomado:', firstEmail
    * karate.set('existingEmail', firstEmail)