import 'package:dartz/dartz.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/data/data_sources/qadaya_local_data_source.dart';
import 'package:khalifa/src/qadaya/data/models/qadiya_model.dart';
import 'package:khalifa/src/qadaya/domain/entities/qadiya.dart';
import 'package:khalifa/src/qadaya/domain/entities/solution.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../../../../core/errors/failure.dart';

class QadayaRepositoryImplementation implements QadayaRepository {
  final QadayaLocalDataSource qadayaLocalDataSource;

  QadayaRepositoryImplementation(this.qadayaLocalDataSource);
  @override
  ResultFuture<void> createNewQadiya({required Qadiya qadiya}) async {
    try {} on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> createNewSolution({
    required Qadiya qadiya,
    required Solution solution,
  }) async {
    try {} on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deleteQadiya({required Qadiya qadiya}) async {
    try {} on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deleteSolution({required Solution solution}) async {
    try {} on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Qadiya>?> getListOfAvailableQadaya() async {
    try {
      final result = await qadayaLocalDataSource.getAllQadaya();
      if (result != null) {
        final listToSend = QadiyaModel.convertToListOfQadaya(qadaya: result);
        return Right(listToSend);
      } else {
        return const Right([]);
      }
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Solution>?> getListOfAvailableSolutions(
      {required Qadiya qadiya}) async {
    try {} on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> saveLastEditedSolution(
      {required Solution solution}) async {
    try {} on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
    throw UnimplementedError();
  }
}
