import 'package:khalifa/src/qadaya/data/models/solution_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/extensions/extensions.dart';
import '../models/database_helper.dart';
import '../models/qadiya_model.dart';

abstract class QadayaLocalDataSource {
  // Future<Database> get database;
  // Future<Database> initDatabase();
  // Future<void> createDatabase({required Database db, required int version});
  Future<void> insertSolution({required SolutionModel solution});
  Future<List<SolutionModel>?> getSolutions({required String qadiyaTitle});
  Future<List<QadiyaModel>?> getAllQadaya();
  Future<void> updateSolution(SolutionModel solution);
  Future<void> deleteSolution(String id);
  Future<void> deleteQadiya(String qadiyaTitle);
  Future<void> insertQadiya(QadiyaModel qadiya);
}

class QadayaLocalDataSourceImplementation implements QadayaLocalDataSource {
  @override
  Future<void> deleteQadiya(String qadiyaTitle) async {
    final Database db = await DatabaseHelper.database;
    await db.delete(
      'qadiya',
      where: 'qadiyaTitle = ?',
      whereArgs: [qadiyaTitle],
    );
  }

  @override
  Future<void> deleteSolution(String id) async {
    final Database db = await DatabaseHelper.database;
    await db.delete(
      'solutions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<QadiyaModel>?> getAllQadaya() async {
    final Database db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('qadiya');
    return List.generate(maps.length, (i) {
      return QadiyaModel(
        qadiyaTitle: maps[i]['qadiyaTitle'],
        priority: maps[i]['priority'],
      );
    });
  }

  @override
  Future<List<SolutionModel>?> getSolutions(
      {required String qadiyaTitle}) async {
    final Database db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'solutions',
      where: 'qadiyaTitle = ?',
      whereArgs: [qadiyaTitle],
    );
    return List.generate(maps.length, (i) {
      return SolutionModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        solution: maps[i]['solution'],
        images: maps[i]['images']?.split(',').toList(),
        topics: List<Mawadie>.from(maps[i]['topics']
            .map((topicMap) => MawadieExtension.fromMap(topicMap))),
      );
    });
  }

  @override
  Future<void> insertSolution({required SolutionModel solution}) async {
    final Database db = await DatabaseHelper.database;
    await db.insert(
      'solutions',
      solution.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateSolution(SolutionModel solution) async {
    final Database db = await DatabaseHelper.database;
    await db.update(
      'solutions',
      solution.toMap(),
      where: 'id = ?',
      whereArgs: [solution.id],
    );
  }

  @override
  Future<void> insertQadiya(QadiyaModel qadiya) async {
    final Database db = await DatabaseHelper.database;
    await db.insert(
      'qadiya',
      qadiya.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
