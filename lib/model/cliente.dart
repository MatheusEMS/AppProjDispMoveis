
class Cliente{

  int id;
  String nome;

  Cliente(this.id, this.nome);


  factory Cliente.fromJson(Map<String, dynamic> json){
    return Cliente(json['id'], json['nome']);
  }



}