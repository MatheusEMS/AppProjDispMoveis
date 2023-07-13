import 'package:app_imc/model/users.dart';
import 'package:app_imc/model/usuario_login.dart';
import 'package:flutter/material.dart';

import '../../service/UserService.dart';
import '../../service/UsuarioService.dart';
import 'home.dart';

class EditConta extends StatefulWidget {
  Users user;
  EditConta({super.key, required this.user});

  @override
  State<EditConta> createState() => _EditContaState();
}

class _EditContaState extends State<EditConta> {
  var _usernomeController = TextEditingController();

  bool _validateNome = false;

  @override
  void initState() {
    setState(() {
      _usernomeController.text = widget.user.nome!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //nome
            TextField(
              controller: _usernomeController,
              decoration: InputDecoration(
                label: const Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          'Nome',
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
                errorText: _validateNome ? 'Campo não pode tá vazio' : null,
              ),
            ),
            const SizedBox(height: 30.0),
            TextButton(
                style: TextButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 18)),
                onPressed: () async {
                  setState(() {
                    _usernomeController.text.isEmpty
                        ? _validateNome = true
                        : _validateNome = false;
                  });
                  if (_validateNome == false) {
                    var _user = Users();
                    _user.id = widget.user.id;
                    _user.nome = _usernomeController.text;
                    _user.Email = widget.user.Email;
                    _user.Senha = widget.user.Senha;

                    var result = await UserService().UpdateUser(_user);
                    print('result: $result');
                    Navigator.pop(context, result);
                  }
                },
                child: const Text('Editar')),
          ],
        ),
      )),
    );
  }
}
