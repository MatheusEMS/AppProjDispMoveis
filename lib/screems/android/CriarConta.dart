import 'package:app_imc/screems/android/login.dart';
import 'package:flutter/material.dart';

import '../../model/users.dart';
import '../../service/UserService.dart';
import '../../service/UsuarioService.dart';
import 'cadastrar_usuario.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({super.key});

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  var _useremailController = TextEditingController();
  var _usersenhaController = TextEditingController();
  var _usernomeController = TextEditingController();

  bool _validateEmail = false;
  bool _validateSenha = false;
  bool _validateNome = false;

  var _userService = UserService();

  _showSucessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(22.0),
          child: Center(
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
                    errorText: _validateNome == true
                        ? 'Campo não pode estar nulo'
                        : null,
                  ),
                ),
                const SizedBox(height: 15.0),
                //email
                TextField(
                  controller: _useremailController,
                  decoration: InputDecoration(
                    label: const Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Text(
                              'Email',
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
                        _validateEmail ? 'Campo não pode tá vazio' : null,
                  ),
                ),
                const SizedBox(height: 15.0),
                //senha
                TextField(
                  controller: _usersenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: const Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Text(
                              'Senha',
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
                        _validateSenha ? 'Campo não pode tá vazio' : null,
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
                        _useremailController.text.isEmpty
                            ? _validateEmail = true
                            : _validateEmail = false;
                        _usersenhaController.text.isEmpty
                            ? _validateSenha = true
                            : _validateSenha = false;
                      });
                      if (_validateNome == false &&
                          _validateEmail == false &&
                          _validateSenha == false) {
                        Users user = Users();
                        user.nome = _usernomeController.text;
                        user.Email = _useremailController.text;
                        user.Senha = _usersenhaController.text;
                        var result = await _userService.SaveUser(user);

                        cadastrar(
                            _usernomeController.text,
                            _useremailController.text,
                            _usersenhaController.text);

                        _showSucessSnackBar("Usuário Criado");
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Criar Conta')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cadastrar(String nome, String email, String senha) {
    new UsuarioService()
        .login(nome: nome, email: email, senha: senha)
        .then((value) => {
              if (value)
                {CadastrarUsuario()}
              else
                {print('Usuario ou senha errados ')}
            });
  }
}
