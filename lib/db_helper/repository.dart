import 'package:app_imc/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //insert user
  InsertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  Logar(table, email, senha) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'Email=? and Senha=?', whereArgs: [email, senha]);
  }

  //Read all record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Read a single record by id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection
        ?.query(table, where: 'Email=?', whereArgs: [itemId]);
  }

  //Read a single record by name Municipio
  readDataByNome(table, nome) async {
    var connection = await database;
    return await connection?.query(table, where: 'nome=?', whereArgs: [nome]);
  }

  //Update User
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete User
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
