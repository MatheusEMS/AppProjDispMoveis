import 'package:app_imc/model/cliente.dart';
import 'package:app_imc/service/LoginService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dao/LoginDAO.dart';
class ClienteService{


  Future<List<Cliente>> getClientes() async{

   return LoginDAO().getUsuarioLogado().then((value) async {

     String token = " Bearer "+value!.token;
      Map<String, String> header = <String, String>{
        "Content-Type":"application/json",
        "Authorization": token
      };

      final response = await http.get(Uri.parse('http://10.0.2.2:8080/cliente/clientes'), headers: header);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return jsonResponse.map<Cliente>( (json)=> Cliente.fromJson(json) ).toList();

      } else {
        throw Exception('Falha ao ler Cliente');
      }
    });

  }

}