import 'package:khalifa/src/authentication/data/model/user_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constant/sqlite_db.dart';

abstract class LocalDataSource {
  Future<Database> initialize();
  Future<Database> get getDataBase;
  Future<String> get getFullPath;
  Future<void> createDataBase(
    Database database,
    int version,
  );

  Future<bool> signIn(UserDB user);

  Future<int> signUp(UserDB user);
}

class LocalDataBaseImplementation implements LocalDataSource {
  Database? _database;
  @override
  Future<Database> initialize() async {
    final path = await getFullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: createDataBase,
      singleInstance: true,
    );
    return database;
  }

  @override
  Future<Database> get getDataBase async {
    if (_database != null) {
      return _database!;
    }
    _database = await initialize();
    return _database!;
  }

  @override
  Future<String> get getFullPath async {
    const String name = "todo.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  @override
  Future<void> createDataBase(Database database, int version) async =>
      SqliteStringManger.createUserTable;

  @override
  Future<bool> signIn(UserDB user) async {
    final Database db = await getDataBase;
    final String email = user.email;
    final String password = user.userPassword;
    var result = await db.rawQuery(
        "select * from users where email = '$email' AND password = '$password'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<int> signUp(UserDB user) async {
    final Database db = await getDataBase;
    return db.insert('users', user.toMap());
  }
}
