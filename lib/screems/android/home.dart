import 'package:app_imc/model/usuario_login.dart';
import 'package:app_imc/screems/android/editConta.dart';
import 'package:flutter/material.dart';
import 'package:app_imc/screems/android/login.dart';
import '../../model/produto.dart';
import '../../model/users.dart';
import '../../service/ProdutoService.dart';
import '../../service/UserService.dart';
import 'ProdutoDispFruta.dart';
import 'ViewProdutoVendedor.dart';
import 'addProdutosVenda.dart';

class Home extends StatefulWidget {
  String estado;
  UsuarioLogin user;
  Home({super.key, required this.estado, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  late List<Users> _userList = <Users>[];
  final _userService = UserService();

  getAllUsersDetails() async {
    var users = await _userService.ReadOneUser(widget.user.email!);
    _userList = <Users>[];

    if (users.isEmpty) {
      print("está vazio");
      setState(() {});
    }

    users.forEach((user) {
      setState(() {
        var userModel = Users();
        userModel.id = user['id'];
        userModel.nome = user['nome'];
        userModel.Email = user['Email'];
        userModel.Senha = user['Senha'];
        _userList.add(userModel);
      });
    });
  }

  _showSucessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    getAllUsersDetails();
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _OptionsBar(BuildContext context) => <Widget>[
        //inicio
        Column(
          children: [
            const Text(
              'Início',
              style: optionStyle,
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 15.0),
            widget.estado.contains('Vendedor')
                ? Column(children: [
                    const Text(
                      'Seus produtos a venda',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                        child: FutureBuilder<List<Produto>>(
                            future: ProdutoService().readAllProduto(
                                widget.user.token!, widget.user.id!),
                            initialData: [],
                            builder: (context, snapshot) {
                              final List<Produto>? produto = snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: produto?.length,
                                  itemBuilder: (context, index) {
                                    final Produto p = produto![index];
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewProdutoVendedor(
                                                        produto: produto[index],
                                                        user: widget.user,
                                                      )));
                                        },
                                        title: Text(p.nome!),
                                        subtitle: Text(
                                            'Quantidade restantes :${p.quantidade!}'),
                                        trailing: Text('R\$ ${p.valor!}'),
                                      ),
                                    );
                                  });
                            })),
                    const SizedBox(height: 25.0),
                    TextButton(
                        style: TextButton.styleFrom(
                          fixedSize: const Size(200, 50),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.lightGreen.shade300,
                          //textStyle: const TextStyle(fontSize: 18)
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddprodutosVenda(
                                        user: widget.user,
                                      ))).then((data) {
                            if (data != null) {
                              _showSucessSnackBar(
                                  "Produto cadastrado com sucesso");
                            }
                          });
                        },
                        child: const Text('Colocar produtos a venda'))
                  ])
                : Column(
                    children: [
                      const Text(
                        'Produtos a venda',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 570,
                        width: double.infinity,
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[100],
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      //fixedSize: const Size(150, 50),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.cyan,
                                      //textStyle: const TextStyle(fontSize: 18)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProdutoDispFruta(
                                                    nomeProduto: 'Morango',
                                                    user: widget.user,
                                                  )));
                                    },
                                    child: const Text('Morango'))),
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[200],
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      //fixedSize: const Size(150, 50),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.cyan,
                                      //textStyle: const TextStyle(fontSize: 18)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProdutoDispFruta(
                                                    nomeProduto: 'Melancia',
                                                    user: widget.user,
                                                  )));
                                    },
                                    child: const Text('Melancia'))),
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[200],
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      //fixedSize: const Size(150, 50),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.cyan,
                                      //textStyle: const TextStyle(fontSize: 18)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProdutoDispFruta(
                                                    nomeProduto: 'Melão',
                                                    user: widget.user,
                                                  )));
                                    },
                                    child: const Text('Melão'))),
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[200],
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      //fixedSize: const Size(150, 50),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.cyan,
                                      //textStyle: const TextStyle(fontSize: 18)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProdutoDispFruta(
                                                    nomeProduto: 'Uva',
                                                    user: widget.user,
                                                  )));
                                    },
                                    child: const Text('Uva'))),
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[200],
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      //fixedSize: const Size(150, 50),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.cyan,
                                      //textStyle: const TextStyle(fontSize: 18)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProdutoDispFruta(
                                                    nomeProduto: 'Laranja',
                                                    user: widget.user,
                                                  )));
                                    },
                                    child: const Text('Laranja'))),
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[200],
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      //fixedSize: const Size(150, 50),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.cyan,
                                      //textStyle: const TextStyle(fontSize: 18)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProdutoDispFruta(
                                                    nomeProduto: 'Limão',
                                                    user: widget.user,
                                                  )));
                                    },
                                    child: const Text('Limão'))),
                          ],
                        ),
                      ),
                    ],
                  )
          ],
        ),
        Column(
          children: [
            const Text(
              'Conta',
              style: optionStyle,
            ),
            const SizedBox(height: 20.0),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_userList[index].nome!),
                        subtitle: Text(_userList[index].Email!),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 20.0),
            TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow,
                  //textStyle: const TextStyle(fontSize: 18)
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditConta(
                                user: _userList[0],
                              ))).then((data) {
                    if (data != null) {
                      _showSucessSnackBar("Usuário atualizado com sucesso");
                      getAllUsersDetails();
                    }
                  });
                },
                child: const Text('Editar')),
            const SizedBox(height: 20.0),
            TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  //textStyle: const TextStyle(fontSize: 18)
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text('Logout')),
          ],
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Início - ${widget.estado}')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(22),
          child: Center(
            child: _OptionsBar(context).elementAt(_selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Conta',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
