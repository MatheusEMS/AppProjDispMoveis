import 'dart:convert';
import 'package:app_imc/dao/LoginDAO.dart';
import 'package:app_imc/model/usuario_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String API_REST = "http://10.0.2.2:8080";

  Map<String, String> headers = <String, String>{
    "Content-type": "application/json",
  };

  String? tokenUsuarioLogado() {
    LoginDAO().getUsuarioLogado().then((value) {
      print("-->> token: " + value!.token);
      return value!.token;
    });
  }

  late UsuarioLogin usuarioLogado;

  Future<UsuarioLogin> login(String login, String senha) async {
    print(login);
    final conteudo =
        json.encode(<String, String>{'email': login, 'senha': senha});

    final resposta = await http.post(Uri.parse(API_REST + "/login"),
        headers: headers, body: conteudo);
    debugPrint("Status Code: " + resposta.statusCode.toString());
    debugPrint("valor: " + resposta.body.toString());

    if (resposta.statusCode == 200) {
      print(resposta.body);
      usuarioLogado = UsuarioLogin.fronJson(jsonDecode(resposta.body));

      //new LoginDAO().adicionar(usuarioLogado);
      return usuarioLogado;
    }

    return usuarioLogado;
  }
}
