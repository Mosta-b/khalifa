import 'package:sqflite/sqflite.dart';

import '../../domain/entities/qadiya.dart';
import '../../domain/entities/solution.dart';

abstract class QadayaLocalDataSource {
  Future<Database> get database;
  Future<Database> initDatabase();
  Future<void> createDatabase({required Database db, required int version});
  Future<void> insertSolution({required Solution solution});
  Future<List<Solution>?> getSolutions();
  Future<List<Qadiya>?> getAllQadaya();
  Future<void> updateSolution(Solution solution);
  Future<void> deleteSolution(String id);
  Future<void> deleteQadiya(String qadiyaTitle);
}
