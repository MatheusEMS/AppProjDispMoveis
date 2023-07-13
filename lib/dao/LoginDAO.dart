import 'package:app_imc/model/login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_imc/dao/openDatabaseDB.dart';

class LoginDAO {
  adicionar(Login u) async {
    final Database db = await getDatabase();
    db.insert('LOGIN', u.toMap());
  }

  Future<Login?> getUsuarioLogado() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('login');

    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        print("id - " + i.toString());
        print("--> " + maps[i]['token']);

        return Login(maps[i]['login'], maps[i]['senha'], maps[i]['token'],
            maps[i]['permissao']);
      })[maps.length - 1];
    } else {
      return null;
    }
  }
}
