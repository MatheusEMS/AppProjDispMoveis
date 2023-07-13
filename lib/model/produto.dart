class Produto {
  int? id;
  String? nome;
  String? valor;
  String? quantidade;
  String? dataColheita;
  int? idUsuario;

  Produto(this.id, this.nome, this.valor, this.quantidade, this.dataColheita,
      this.idUsuario);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'quantidade': quantidade,
      'dataColheita': dataColheita,
      'idUsuario': idUsuario
    };
  }

  factory Produto.fronJson(Map<String, dynamic> json) {
    return Produto(json['id'], json['nome'], json['valor'], json['quantidade'],
        json['dataColheita'], json['idUsuario']);
  }
}
