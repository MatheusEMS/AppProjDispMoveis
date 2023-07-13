import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    print('aqui');
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database = await openDatabase(path,
        version: 1, onCreate: _createDatabase, onUpgrade: _onUpgrade);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    print('set database');
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,nome TEXT,Email TEXT,Senha TEXT);";

    await database.execute(sql);

    //fetchFileData(database);
  }

  fetchFileData(Database database) async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/municipios.txt');

    //String sql6 = "ALTER TABLE propriedades ADD nomePropri TEXT;";
    //await database.execute(sql6);
    print("alter table imagem");
    await database.execute(responseText);
    //print(responseText);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('update database');
    if (oldVersion < newVersion) {
      fetchFileData(db);
    }
  }
}
