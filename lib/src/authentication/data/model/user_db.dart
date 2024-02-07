import '../../../../core/constant/sqlite_db.dart';

class UserDB {
  final int? id;
  final String userPassword;
  final String email;
  const UserDB({
    this.id,
    required this.userPassword,
    required this.email,
  });

  UserDB.fromRow(Map<String, Object?> map)
      : id = map[SqliteStringManger.idColumn] as int,
        email = map[SqliteStringManger.emailColumn] as String,
        userPassword = map[SqliteStringManger.passwordColumn] as String;
  Map<String, dynamic> toMap() => {
        SqliteStringManger.idColumn: id,
        SqliteStringManger.emailColumn: email,
        SqliteStringManger.passwordColumn: userPassword,
      };
  @override
  String toString() => "Person , ID = $id, Email = $email";
}
