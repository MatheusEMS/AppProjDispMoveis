class Login {
  String email;
  String senha;
  String token;
  String permissao;

  Login(this.email, this.senha, this.token, this.permissao);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        json['email'], json['senha'], json['token'], json['permissao']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
      'token': token,
      'permissao': permissao
    };
  }
}
