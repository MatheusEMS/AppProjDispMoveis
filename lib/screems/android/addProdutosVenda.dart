import 'package:app_imc/model/usuario_login.dart';
import 'package:app_imc/service/ProdutoService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddprodutosVenda extends StatefulWidget {
  UsuarioLogin user;
  AddprodutosVenda({super.key, required this.user});

  @override
  State<AddprodutosVenda> createState() => _EditContaState();
}

List<String> list = <String>[
  'Morango',
  'Melancia',
  'Melão',
  'Uva',
  'Laranja',
  'Limão'
];

class _EditContaState extends State<AddprodutosVenda> {
  final now = DateTime.now();

  var _produtoNomeController = TextEditingController();
  var _produtoValorController = TextEditingController();
  var _produtoQuantidController = TextEditingController();
  var _produtoDataController = TextEditingController();

  //var _produtoService = ProdutoService();

  _showSucessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  String dropdownValue = list.first;

  final maskData = MaskTextInputFormatter(
      mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});

  bool _validateNome = false;
  bool _validateValor = false;
  bool _validateQuant = false;
  bool _validateData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionando produtos '),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Adicionar Produto',
                  style: TextStyle(fontSize: 20),
                ),
                //nome
                Container(
                  width: 200, // Defina a largura desejada
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    elevation: 22,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    isExpanded: true, // Define o DropdownButton como expandido
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10.0),
                //Valor
                TextField(
                  controller: _produtoValorController,
                  decoration: InputDecoration(
                    label: const Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Text(
                              'Valor por Unidade',
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
                    errorText:
                        _validateValor ? 'Campo não pode tá vazio' : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                //quantidade
                TextField(
                  controller: _produtoQuantidController,
                  decoration: InputDecoration(
                    label: const Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Text(
                              'Quantidade',
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
                    errorText:
                        _validateQuant ? 'Campo não pode tá vazio' : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                //data
                TextField(
                  controller: _produtoDataController,
                  inputFormatters: [maskData],
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  decoration: InputDecoration(
                    labelText: "Data de colheita *",
                    hintText: "99/99/9999",
                    errorText: _validateData ? 'Campo não pode tá vazio' : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30.0),
                TextButton(
                    style: TextButton.styleFrom(
                        fixedSize: const Size(200, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(fontSize: 18)),
                    onPressed: () async {
                      print(dropdownValue);
                      setState(() {
                        dropdownValue.isEmpty
                            ? _validateNome = true
                            : _validateNome = false;
                        _produtoValorController.text.isEmpty
                            ? _validateValor = true
                            : _validateValor = false;
                        _produtoQuantidController.text.isEmpty
                            ? _validateQuant = true
                            : _validateQuant = false;
                        _produtoDataController.text.isEmpty
                            ? _validateData = true
                            : _validateData = false;
                      });
                      if (_validateNome == false &&
                          _validateValor == false &&
                          _validateQuant == false &&
                          _validateData == false) {
                        new ProdutoService()
                            .addProduto(
                                nome: dropdownValue,
                                valor: _produtoValorController.text,
                                quantidade: _produtoQuantidController.text,
                                data: _produtoDataController.text,
                                idUsuario: widget.user.id!,
                                tokenuser: widget.user.token!)
                            .then((value) => {
                                  if (value)
                                    {Navigator.pop(context, value)}
                                  else
                                    {print('Erro add')}
                                });
                      }
                    },
                    child: const Text('Adicionar produto')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
