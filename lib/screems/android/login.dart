import 'package:app_imc/model/usuario.dart';
import 'package:app_imc/screems/android/Imc.dart';
import 'package:app_imc/screems/android/cadastrar_usuario.dart';
import 'package:app_imc/service/LoginService.dart';
import 'package:app_imc/service/UsuarioService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'CriarConta.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _showSucessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  var _useremailController = TextEditingController();
  var _usersenhaController = TextEditingController();

  bool _validateEmail = false;
  bool _validateSenha = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Comprador',
              ),
              Tab(
                text: 'Vendedor',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //comprador
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(22.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Entrar como comprador',
                        style: TextStyle(fontSize: 20),
                      ),
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
                        enableSuggestions: false,
                        autocorrect: false,
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
                          errorText: _validateSenha ? 'Senha Incorreta' : null,
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
                              _useremailController.text.isEmpty
                                  ? _validateEmail = true
                                  : _validateEmail = false;
                              _usersenhaController.text.isEmpty
                                  ? _validateSenha = true
                                  : _validateSenha = false;
                            });
                            if (_validateEmail == false &&
                                _validateSenha == false) {
                              logarComprador(_useremailController.text,
                                  _usersenhaController.text, context);
                            }
                          },
                          child: const Text('Logar')),
                      const SizedBox(height: 25.0),
                      TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: const Size(120, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              textStyle: const TextStyle(fontSize: 18)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CriarConta()));
                          },
                          child: const Text('Criar Conta')),
                    ],
                  ),
                ),
              ),
            ),
            //vendedor
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(22.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Entrar como Vendedor',
                        style: TextStyle(fontSize: 20),
                      ),
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
                        enableSuggestions: false,
                        autocorrect: false,
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
                          errorText: _validateSenha ? 'Senha Incorreta' : null,
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
                              _useremailController.text.isEmpty
                                  ? _validateEmail = true
                                  : _validateEmail = false;
                              _usersenhaController.text.isEmpty
                                  ? _validateSenha = true
                                  : _validateSenha = false;
                            });
                            if (_validateEmail == false &&
                                _validateSenha == false) {
                              logarVendedor(_useremailController.text,
                                  _usersenhaController.text, context);
                            }
                          },
                          child: const Text('Logar')),
                      const SizedBox(height: 25.0),
                      TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: const Size(120, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              textStyle: const TextStyle(fontSize: 18)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CriarConta()));
                          },
                          child: const Text('Criar Conta')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  alert(BuildContext context) {
    return AlertDialog(
      title: Text('Erro ao Logar'),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'OK'), child: Text('OK'))
      ],
    );
  }

  logarComprador(String login, String senha, BuildContext context) {
    new LoginService().login(login, senha).then((value) {
      print(value.toMap());
      if (value != null) {
        print('Usuario logado... ' + value.toString());
        //  Modular.to.navigate('/cadastrar_clientes');

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      estado: 'Comprador',
                      user: value,
                    )));

        //Navigator.push(context, MaterialPageRoute(builder: (context){
        // return CadastrarUsuario();
        //}));
      } else {
        print('Usuario ou senha errados ');

        showDialog(
            context: context,
            builder: (BuildContext context) => this.alert(context));
      }
    });
  }

  logarVendedor(String login, String senha, BuildContext context) async {
    new LoginService().login(login, senha).then((value) {
      print(value.toMap());
      if (value != null) {
        print('Usuario logado... ' + value.toString());
        print('deu login');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      estado: 'Vendedor',
                      user: value,
                    )));
      } else {
        print('Usuario ou senha errados ');

        showDialog(
            context: context,
            builder: (BuildContext context) => this.alert(context));
      }
    });
  }
}




/*

ElevatedButton(
          child: Text("Login"),
          onPressed: (){
            debugPrint("Clicou");

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Imc();
            }));


* */