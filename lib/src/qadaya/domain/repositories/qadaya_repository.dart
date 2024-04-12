import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/entities/qadiya.dart';
import 'package:khalifa/src/qadaya/domain/entities/solution.dart';

abstract class QadayaRepository {
  ResultFuture<List<Qadiya>?> getListOfAvailableQadaya();
  ResultFuture<List<Solution>?> getListOfAvailableSolutions({
    required Qadiya qadiya,
  });

  ResultFuture<void> createNewQadiya({required Qadiya qadiya});
  ResultFuture<void> createNewSolution({
    required Qadiya qadiya,
    required Solution solution,
  });

  ResultFuture<void> saveLastEditedSolution({
    required Solution solution,
  });
  ResultFuture<void> deleteSolution({
    required Solution solution,
  });
  ResultFuture<void> deleteQadiya({
    required Qadiya qadiya,
  });
}
