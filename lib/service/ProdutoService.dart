import 'dart:convert';
import 'package:app_imc/model/produto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProdutoService {
  final String API_REST = "http://192.168.0.38:8080";

  Future<bool> addProduto(
      {required String nome,
      required String valor,
      required String quantidade,
      required String data,
      required int idUsuario,
      required String tokenuser}) async {
    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    print('teste $data');

    String idString = idUsuario.toString();

    final conteudo = json.encode(<String, String>{
      'nome': nome,
      'valor': valor,
      'quantidade': quantidade,
      'dataColheita': data,
      'idUsuario': idString
    });

    final resposta = await http.post(Uri.parse(API_REST + '/produto/add'),
        headers: header, body: conteudo, encoding: null);

    debugPrint('-->' + resposta.statusCode.toString());
    debugPrint('-->' + resposta.body.toString());

    if (resposta.statusCode == 200) {
      //UsuarioLogin u = UsuarioLogin.fronJson(jsonDecode(resposta.body));
      //debugPrint('-->' + resposta.body.toString());
      //new UsuarioDAO().usuarioLogado(u);

      /* localStorage.setItem("USUARIO_LOGADO", u.toMap());
      Map<String, dynamic> data = localStorage.getItem("USUARIO_LOGADO");
      print('vai retornar o usuário ......'+data.toString());*/
      return true;
    }
    return false;
  }

  Future<List<Produto>> readAllProduto(String tokenuser, int idusuario) async {
    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    final resposta = await http.get(
        Uri.parse(API_REST + '/produto/readAllProduto/$idusuario'),
        headers: header);

    if (resposta.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(resposta.bodyBytes));

      print(jsonResponse);

      return jsonResponse
          .map<Produto>((json) => Produto.fronJson(json))
          .toList();
    } else {
      throw Exception('Falha ao ler Cliente');
    }
  }

  Future<List<Produto>> readAllProdutoFruta(
      String tokenuser, String nomeFruta) async {
    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    final resposta = await http.get(
        Uri.parse(API_REST + '/produto/readAllProdutoFruta/$nomeFruta'),
        headers: header);

    if (resposta.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(resposta.bodyBytes));

      print(jsonResponse);

      return jsonResponse
          .map<Produto>((json) => Produto.fronJson(json))
          .toList();
    } else {
      throw Exception('Falha ao ler Cliente');
    }
  }

  Future<bool> excluirProduto(
      {required int id, required String tokenuser}) async {
    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    String idString = id.toString();

    final conteudo = json.encode(<String, String>{'id': idString});

    final resposta = await http.post(Uri.parse(API_REST + '/produto/deletar'),
        headers: header, body: conteudo);

    debugPrint('-->' + resposta.statusCode.toString());
    debugPrint('-->' + resposta.body.toString());

    if (resposta.statusCode == 200) {
      //UsuarioLogin u = UsuarioLogin.fronJson(jsonDecode(resposta.body));
      //debugPrint('-->' + resposta.body.toString());
      //new UsuarioDAO().usuarioLogado(u);

      /* localStorage.setItem("USUARIO_LOGADO", u.toMap());
      Map<String, dynamic> data = localStorage.getItem("USUARIO_LOGADO");
      print('vai retornar o usuário ......'+data.toString());*/
      return true;
    }
    return false;
  }

  Future<bool> editarProduto(int idproduto, String nome, String valor,
      String qunatd, String data, String tokenuser) async {
    String idString = idproduto.toString();
    final conteudo = json.encode(<String, String>{
      'id': idString,
      'nome': nome,
      'valor': valor,
      'quantidade': qunatd,
      'dataColheita': data
    });

    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    final resposta = await http.post(
        Uri.parse(API_REST + '/produto/EditarProduto'),
        headers: header,
        body: conteudo);

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

  Future<bool> PagamentoProduto(
      int idproduto, String qunatd, String tokenuser) async {
    String idString = idproduto.toString();
    final conteudo = json.encode(<String, String>{
      'id': idString,
      'quantidade': qunatd,
    });

    String token = " Bearer " + tokenuser;
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token
    };

    final resposta = await http.post(Uri.parse(API_REST + '/produto/Pagamento'),
        headers: header, body: conteudo);

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
