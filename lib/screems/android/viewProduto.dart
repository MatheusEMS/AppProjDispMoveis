import '../../model/produto.dart';
import 'package:flutter/material.dart';
import 'package:app_imc/model/usuario_login.dart';
import '../../service/UsuarioService.dart';
import 'package:app_imc/screems/android/PaginaCompra.dart';

class ViewProduto extends StatefulWidget {
  Produto produto;
  UsuarioLogin user;
  ViewProduto({super.key, required this.produto, required this.user});

  @override
  State<ViewProduto> createState() => _ViewProdutoState();
}

class _ViewProdutoState extends State<ViewProduto> {
  var _produtoQuantidController = TextEditingController();

  bool _validateQuant = false;
  bool _validateQuant2 = false;
  int verifQuant = 0;
  Future<String> nomeVendedor = Future<String>.value('Valor inicial');
  @override
  void initState() {
    nomeVendedor = UsuarioService().ReadNome(widget.user.token!,widget.user.id!);
    verifQuant = int.parse(widget.produto.quantidade!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do produto'),
      ),
      body: Container(
        padding: EdgeInsets.all(22),
        child: ListView(
          children: [
            Row(
              children: [
                const Text('Produto:', style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.nome ?? '',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text('Valor por unidade:',
                    style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('R\$${widget.produto.valor}',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text('Data da colheita:', style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.dataColheita!,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quantidades disponíveis:',
                    style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(widget.produto.quantidade!,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            /*
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vendido por:', style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w600)),
                ),
              ],
            ),*/
            const SizedBox(
              height: 5,
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _produtoQuantidController,
              decoration: InputDecoration(
                label: const Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          'Quantidade que deseja comprar',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                errorText: _validateQuant
                    ? 'Campo não pode estar vazio'
                    : (_validateQuant2
                        ? 'Quantidade maior do que se tem disponível'
                        : null),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 25.0),
            TextButton(
                style: TextButton.styleFrom(
                  //fixedSize: const Size(150, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  //textStyle: const TextStyle(fontSize: 18)
                ),
                onPressed: () async {
                  setState(() {
                    _produtoQuantidController.text.isEmpty
                        ? _validateQuant = true
                        : _validateQuant = false;
                  });
                  if (_validateQuant == false) {
                    double quantidade =
                        double.parse(_produtoQuantidController.text);
                    setState(() {
                      quantidade > verifQuant
                          ? _validateQuant2 = true
                          : _validateQuant2 = false;
                    });

                    if (_validateQuant2 == false) {
                      
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaginaCompra(
                                    produto: widget.produto,
                                    quantd: quantidade,
                                    user: widget.user,
                                  )));
                    }
                  }
                },
                child: const Text('Comprar')),
          ],
        ),
      ),
    );
  }
}
