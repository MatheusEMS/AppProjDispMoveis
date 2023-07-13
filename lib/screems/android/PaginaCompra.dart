import 'package:app_imc/model/usuario.dart';
import 'package:app_imc/model/usuario_login.dart';
import 'package:flutter/material.dart';

import '../../model/produto.dart';
import '../../service/ProdutoService.dart';
import 'home.dart';

class PaginaCompra extends StatefulWidget {
  Produto produto;
  double quantd;
  UsuarioLogin user;
  PaginaCompra(
      {super.key,
      required this.produto,
      required this.quantd,
      required this.user});

  @override
  State<PaginaCompra> createState() => _PaginaCompraState();
}

class _PaginaCompraState extends State<PaginaCompra> {
  double valorTotal = 0;
  double valorTotalCerto = 0;
  String novoQuantd = '';

  void initState() {
    double preco = double.parse(widget.produto.valor!);
    valorTotal = widget.quantd * preco;
    String valorFormatado = valorTotal.toStringAsFixed(2);
    valorTotalCerto = double.parse(valorFormatado);
    double antigoQuantid = double.parse(widget.produto.quantidade!);
    double total = antigoQuantid - widget.quantd;
    int totalInt = total.toInt();
    print(totalInt);
    novoQuantd = '$totalInt';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de compra'),
      ),
      body: Container(
          padding: EdgeInsets.all(22),
          child: ListView(
            children: [
              Row(
                children: [
                  const Text('Produto escolhido:',
                      style: TextStyle(fontSize: 20)),
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
                  const Text('Quantidade:', style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('${widget.quantd}',
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Valor total:', style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('R\$$valorTotalCerto',
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    //fixedSize: const Size(150, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    //textStyle: const TextStyle(fontSize: 18)
                  ),
                  onPressed: () async {
                    new ProdutoService()
                        .PagamentoProduto(
                            widget.produto.id!, novoQuantd, widget.user.token!)
                        .then((value) {
                      if (value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      estado: 'Comprador',
                                      user: widget.user,
                                    )));
                      } else {
                        print('erro');
                      }
                    });
                    /*
                    print(widget.quantd);
                    var produto = Produto();
                    produto.id = widget.produto.id;
                    produto.nome = widget.produto.nome;
                    produto.valor = widget.produto.valor;
                    produto.quantidade = novoQuantd;
                    produto.dataColheita = widget.produto.dataColheita;
                    produto.idUsuario = widget.user.id;
                    await _produtoService.UpdateProduto(produto);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PagamentoConfirmado(
                                  user: widget.user,
                                )));*/
                  },
                  child: const Text('Prosseguir Pagamento')),
            ],
          )),
    );
  }
}
