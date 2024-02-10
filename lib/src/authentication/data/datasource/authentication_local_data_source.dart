import 'dart:developer';

import 'package:khalifa/src/authentication/data/model/user_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constant/sqlite_db.dart';

abstract class LocalDataSource {
  Future<bool> getUser();
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
    log("look at this database $database");
    return database;
  }

  @override
  Future<Database> get getDataBase async {
    if (_database != null) {
      log("return this");
      return _database!;
    }
    _database = await initialize();
    log("or this $_database");
    return _database!;
  }

  @override
  Future<String> get getFullPath async {
    const String name = "todo.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  @override
  Future<void> createDataBase(Database database, int version) async {
    await database.execute(SqliteStringManger.createUserTable);
  }

  @override
  Future<bool> signIn(UserDB user) async {
    final Database db = await getDataBase;
    final String email = user.email;
    final String password = user.userPassword;
    var result = await db.rawQuery(
        "select * from users where email = '$email' AND password = '$password'");
    return result.length == 1;
  }

  @override
  Future<int> signUp(UserDB user) async {
    final Database db = await getDataBase;
    return db.insert('users', user.toMap());
  }

  @override
  Future<bool> getUser() async {
    final Database db = await getDataBase;

    // Check if there are already registered users
    var result = await db.query(SqliteStringManger.userTable);

    if (result.isNotEmpty) {
      // There are registered users
      log("Database has registered users.");
      return true;
    } else {
      // No registered users
      log("Database does not have registered users.");
      return false;
    }
  }
}
