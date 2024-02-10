class SqliteStringManger {
  static const userTable = 'users';

  static const idColumn = 'id';
  static const emailColumn = 'email';
  static const passwordColumn = "password";

  static const createUserTable =
      '''CREATE TABLE users ( "id"	INTEGER NOT NULL, "email"	TEXT NOT NULL UNIQUE, "password"	TEXT, PRIMARY KEY("id" AUTOINCREMENT) );''';
}
