import 'package:app_imc/dao/usuarioDAO.dart';
import 'package:app_imc/model/cliente.dart';
import 'package:app_imc/model/usuario.dart';
import 'package:app_imc/service/ClienteService.dart';
import 'package:app_imc/service/usuarioService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListarUsuarios extends StatelessWidget {
   ListarUsuarios({Key? key}) : super(key: key);

  //final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  /*

  class RandomFruitsState extends State<RandomFruits>  {  final _biggerFont = const TextStyle(fontSize: 18.0);
  QueryCtr _query = new  QueryCtr();  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Load data from DB'),
      ),
      body: FutureBuilder<List>(
        future: _query.getAllFruits(),
        initialData: List(),
        builder: (context, snapshot) {
            return snapshot.hasData ?
             new ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return _buildRow(snapshot.data[i]);
              },
            )
            : Center(
                          child: CircularProgressIndicator(),
                        );
        },
      )
    );
  }  Widget _buildRow(Fruits fruit) {
    return new ListTile(
      title: new Text(fruit.name, style: _biggerFont),
    );
  }
}


  * */

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: Scaffold(
           appBar: AppBar(
             title: Text('Listar'),
           ),
           body: FutureBuilder<List<Cliente>>(
             //future: UsuarioDAO().getUsuarios(),
             //future: UsuarioService().getUsuarios(),
             future: ClienteService().getClientes(),
             initialData: [],
             builder: (context, snapshot){
               final List<Cliente>? clientes = snapshot.data;
               //return snapshot.hasData?
               return ListView.builder(
                 padding: const EdgeInsets.all(10.0),
                 itemCount: clientes?.length,
                 itemBuilder: (context, i) {
                   final Cliente u = clientes![i];

                   return _buildRow(u);
                 },

               );
             },
           )

       ),
     );
   }
}
final _biggerFont = const TextStyle(fontSize: 18.0);
Widget _buildRow(Cliente u) {
  return new ListTile(
    title: new Text(u.nome, style: _biggerFont),
  );
}
