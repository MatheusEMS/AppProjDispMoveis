import 'package:app_imc/dao/openDatabaseDB.dart';
import 'package:app_imc/model/usuario.dart';
import 'package:app_imc/model/usuario_login.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDAO {
  usuarioLogado(UsuarioLogin u) async {
    final Database db = await getDatabase();
    db.insert('USUARIO', u.toMap());
  }

  adicionar(Usuario u) async {
    final Database db = await getDatabase();
    db.insert('USUARIO', u.toMap());
  }

  Future<UsuarioLogin?> getUserLogado() async {
    // Get a reference to the database.
    print('GET USUARIO');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuario');

    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return UsuarioLogin(maps[i]['id'], maps[i]['nome'], maps[i]['email'],
            maps[i]['senha'], maps[i]['token']);
      })[0];
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getUsuarios() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('USUARIO');

    return List.generate(maps.length, (i) {
      return Usuario(maps[i]['id'], maps[i]['nome'], maps[i]['email']);
    });
  }
}

/*

  //USUARIO
  saveUsuario(UsuarioDb u) async {
    print('SAVE USUARIO');
    final db = await _db;

    deleteUser().then((value) => db.insert('usuario', u.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace));
  }

  Future<UsuarioDb?> getUser() async {
    // Get a reference to the database.
    print('GET USUARIO');
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('usuario');

    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return UsuarioDb.fromJson(maps[i]);
      })[0];
    } else {
      return null;
    }
  }


* */