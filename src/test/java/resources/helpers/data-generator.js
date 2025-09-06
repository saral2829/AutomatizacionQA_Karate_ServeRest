function fn() {
  var random = Math.floor(Math.random() * 100000);
  return {
    nome: 'Usuario_' + random,
    email: 'user' + random + '@test.com',
    password: '123456',
    administrador: 'true'
  };
}
