import 'dart:convert';
import 'package:app_imc/dao/usuarioDAO.dart';
import 'package:app_imc/model/usuario_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UsuarioService {
  final String API_REST = "http://10.0.2.2:8080";

  Map<String, String> headers = <String, String>{
    'Content-type': 'application/json'
  };

  //static final LocalStorage localStorage = new LocalStorage("logado.json");

  UsuarioLogin? getUsuario_logado() {
    print('vai retornar o usuário ......');

    new UsuarioDAO().getUserLogado().then((value) {
      return value;
    });
  }

  Future<String> ReadNome(String tokenuser, int idusuario) async {
    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    final resposta = await http.get(
        Uri.parse(API_REST + '/cliente/LerNome/$idusuario'),
        headers: header);

    if (resposta.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(resposta.bodyBytes));

      print(jsonResponse);

      return jsonResponse
          .map<UsuarioLogin>((json) => UsuarioLogin.fronJson(json))
          .toList();
    } else {
      throw Exception('Falha ao ler Cliente');
    }
  }

  Future<bool> login(
      {required String nome,
      required String email,
      required String senha}) async {
    final conteudo = json
        .encode(<String, String>{'nome': nome, 'email': email, 'senha': senha});

    final resposta = await http.post(Uri.parse(API_REST + '/CriarConta'),
        headers: headers, body: conteudo, encoding: null);

    debugPrint('-->' + resposta.statusCode.toString());
    debugPrint('-->' + resposta.body.toString());

    if (resposta.statusCode == 200) {
      UsuarioLogin u = UsuarioLogin.fronJson(jsonDecode(resposta.body));
      debugPrint('-->' + resposta.body.toString());
      //new UsuarioDAO().usuarioLogado(u);

      /* localStorage.setItem("USUARIO_LOGADO", u.toMap());
      Map<String, dynamic> data = localStorage.getItem("USUARIO_LOGADO");
      print('vai retornar o usuário ......'+data.toString());*/
      return true;
    }
    return false;
  }

  Future<bool> editarconta(int id, String nome, String tokenuser) async {
    String idString = id.toString();
    final conteudo = json.encode(<String, String>{
      'id': idString,
      'nome': nome,
    });

    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    final resposta = await http.post(Uri.parse(API_REST + '/EditarConta'),
        headers: header, body: conteudo, encoding: null);

    debugPrint('-->' + resposta.statusCode.toString());
    debugPrint('-->' + resposta.body.toString());

    if (resposta.statusCode == 200) {
      //UsuarioLogin u = UsuarioLogin.fronJson(jsonDecode(resposta.body));
      debugPrint('-->' + resposta.body.toString());
      //new UsuarioDAO().usuarioLogado(u);

      /* localStorage.setItem("USUARIO_LOGADO", u.toMap());
      Map<String, dynamic> data = localStorage.getItem("USUARIO_LOGADO");
      print('vai retornar o usuário ......'+data.toString());*/
      return true;
    }
    return false;
  }
}
