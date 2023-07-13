import 'package:app_imc/screems/android/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.orange),
    home: const Login(),
  ));

  //runApp(ModularApp(module: AppModule(), child: Login()));
}
