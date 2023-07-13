class UsuarioLogin {
  int? id;
  String? nome;
  String? email;
  String? senha;
  String? token;

  UsuarioLogin(this.id, this.nome, this.email, this.senha, this.token);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'token': token,
    };
  }

  factory UsuarioLogin.fronJson(Map<String, dynamic> json) {
    return UsuarioLogin(
        json['id'], json['nome'], json['email'], json['senha'], json['token']);
  }
}
