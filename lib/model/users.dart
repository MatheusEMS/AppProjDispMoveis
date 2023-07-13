class Users {
  int? id;
  String? nome;
  String? Email;
  String? Senha;

  Users({this.id, this.nome, this.Email, this.Senha});

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['nome'] = nome!;
    mapping['email'] = Email!;
    mapping['senha'] = Senha!;
    return mapping;
  }
}
