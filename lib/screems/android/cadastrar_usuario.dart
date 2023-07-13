import 'package:app_imc/dao/usuarioDAO.dart';
import 'package:app_imc/model/usuario.dart';
import 'package:app_imc/model/usuario_login.dart';
import 'package:app_imc/screems/android/listar_usuarios.dart';
import 'package:app_imc/screems/android/login.dart';
import 'package:app_imc/service/UsuarioService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastrarUsuario extends StatelessWidget {
  //const CadastrarUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastre-se '),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    child: Text("Cadastrar"),
                    onPressed: () {
                      Usuario u = new Usuario(5, 'Teste', 'tes@gmail');
                      new UsuarioDAO().adicionar(u);

                      debugPrint('cadastrou');
                    },
                  ),
                ),
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    child: Text("Listar"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ListarUsuarios();
                      }));
                    },
                  ),
                ),
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    child: Text("Deslogar"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
