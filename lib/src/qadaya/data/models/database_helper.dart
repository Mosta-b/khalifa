import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'Qadaya.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static void _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE qadiya(
      qadiyaTitle TEXT PRIMARY KEY,
      priority INTEGER
    )
  ''');
    await db.execute('''
    CREATE TABLE solutions(
      id TEXT PRIMARY KEY,
      title TEXT,
      solution TEXT,
      images TEXT,
      topics TEXT,
      qadiyaTitle TEXT,
      FOREIGN KEY (qadiyaTitle) REFERENCES qadiya(qadiyaTitle) ON DELETE CASCADE
    )
  ''');
  }
}
