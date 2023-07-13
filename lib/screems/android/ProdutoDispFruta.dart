import 'package:app_imc/model/usuario_login.dart';
import 'package:app_imc/screems/android/viewProduto.dart';
import 'package:flutter/material.dart';
import '../../model/produto.dart';
import '../../service/ProdutoService.dart';

class ProdutoDispFruta extends StatefulWidget {
  String nomeProduto;
  UsuarioLogin user;
  ProdutoDispFruta({super.key, required this.nomeProduto, required this.user});

  @override
  State<ProdutoDispFruta> createState() => _EditContaState();
}

class _EditContaState extends State<ProdutoDispFruta> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.nomeProduto} disponíveis'),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: FutureBuilder<List<Produto>>(
                future: ProdutoService().readAllProdutoFruta(
                    widget.user.token!, widget.nomeProduto),
                initialData: [],
                builder: (context, snapshot) {
                  final List<Produto>? produto = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: produto?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewProduto(
                                            produto: produto[index],
                                            user: widget.user,
                                          )));
                            },
                            title:
                                Text('Preço:R\$ ${produto![index].valor} cada'),
                            subtitle:
                                Text('Quantidade ${produto[index].quantidade}'),
                            trailing: Text(produto[index].dataColheita!),
                          ),
                        );
                      });
                })),
      ),
    );
  }
}
