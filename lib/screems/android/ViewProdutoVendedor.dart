import 'package:app_imc/model/usuario_login.dart';
import 'package:app_imc/screems/android/home.dart';
import 'package:flutter/material.dart';
import '../../model/produto.dart';
import '../../service/ProdutoService.dart';
import 'EditProdutoVendas.dart';

class ViewProdutoVendedor extends StatefulWidget {
  Produto produto;
  UsuarioLogin user;
  ViewProdutoVendedor({super.key, required this.produto, required this.user});

  @override
  State<ViewProdutoVendedor> createState() => _ViewProdutoVendedorState();
}

class _ViewProdutoVendedorState extends State<ViewProdutoVendedor> {
  @override
  void initState() {
    super.initState();
  }

  _deleteFormDialog(BuildContext context, int id) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text('Excluir Produto ${widget.produto.nome}'),
            content: const Text('Tem certeza que deseja excluir?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () async {
                    new ProdutoService()
                        .excluirProduto(
                            id: widget.produto.id!,
                            tokenuser: widget.user.token!)
                        .then((value) => {
                              if (value)
                                {
                                  _showSucessSnackBar(
                                      "Produto Excluido com sucesso"),
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(
                                                estado: 'Vendedor',
                                                user: widget.user,
                                              )))
                                }
                              else
                                {print('Usuario ou senha errados ')}
                            });
                    /*
                    var result = await _produtoService.deleteProduto(id);
                    _showSucessSnackBar("Produto Excluido com sucesso");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  estado: 'Vendedor',
                                  user: widget.user,
                                )));*/
                  },
                  child: const Text(
                    'Excluir',
                  )),
            ],
          );
        });
  }

  _showSucessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações do produto"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text('Produto:',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.nome ?? '',
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text('Quantidade:',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.quantidade ?? '',
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text('Valor por unidade :',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.valor ?? '',
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text('Data Colheita:',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.dataColheita ?? '',
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: TextButton(
                  style: TextButton.styleFrom(
                    //fixedSize: const Size(150, 50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.yellow,
                    //textStyle: const TextStyle(fontSize: 18)
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProdutoVendas(
                                  produto: widget.produto,
                                  user: widget.user,
                                ))).then((value) {
                      if (value != null) {}
                    });
                  },
                  child: const Text('Editar produto')),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: TextButton(
                  style: TextButton.styleFrom(
                    //fixedSize: const Size(150, 50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.redAccent,
                    //textStyle: const TextStyle(fontSize: 18)
                  ),
                  onPressed: () {
                    //produtosEstatica.removeAt(widget.index);
                    _deleteFormDialog(context, widget.produto.id!);

                    //Navigator.pop(context);
                  },
                  child: const Text('Deletar produto')),
            ),
          ],
        ),
      ),
    );
  }
}
