@RegisterUser
Feature:Resgistrar Usuario

  Background:
    * url baseUrl
    * def user = callonce read('classpath:resources/helpers/data-generator.js')
    * print 'Usuario generado para todo el feature:', user.email

  @smoke
  Scenario: Caso Positivo - Creación de un usuario válido
    Given path 'usuarios'
    And request read('classpath:resources/requests/create-user.json')
    * print user
    When method post
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def userId = response._id
    * karate.write({ userId: userId, email: user.email }, 'user-data.json')
    * print 'Usuario creado:', user.email, 'con ID:', userId

  @negativo
  Scenario: Caso Negativo - Creación de un usuario con un email duplicado
    Given path 'usuarios'
    And request read('classpath:resources/requests/create-user.json')
    * print user
    When method post
    Then status 400
    And match response == { message: 'Este email já está sendo usado' }
    * print 'Intento duplicado con:', user.email
