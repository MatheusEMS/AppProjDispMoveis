class Usuario {
  int id;
  String nome;
  String email;

  Usuario(this.id, this.nome, this.email);

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'email': email};
  }
}
