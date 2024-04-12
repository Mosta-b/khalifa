import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/entities/qadiya.dart';
import 'package:khalifa/src/qadaya/domain/entities/solution.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

class QadayaRepositoryImplementation implements QadayaRepository {
  @override
  ResultFuture<void> createNewQadiya({required Qadiya qadiya}) async {
    // TODO: implement createNewQadiya
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> createNewSolution(
      {required Qadiya qadiya, required Solution solution}) async {
    // TODO: implement createNewSolution
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deleteQadiya({required Qadiya qadiya}) async {
    // TODO: implement deleteQadiya
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deleteSolution({required Solution solution}) async {
    // TODO: implement deleteSolution
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Qadiya>?> getListOfAvailableQadaya() async {
    // TODO: implement getListOfAvailableQadaya
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Solution>?> getListOfAvailableSolutions(
      {required Qadiya qadiya}) async {
    // TODO: implement getListOfAvailableSolutions
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> saveLastEditedSolution(
      {required Solution solution}) async {
    // TODO: implement saveLastEditedSolution
    throw UnimplementedError();
  }
}
