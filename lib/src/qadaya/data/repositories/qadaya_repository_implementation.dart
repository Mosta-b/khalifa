import 'package:dartz/dartz.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/data/data_sources/qadaya_local_data_source.dart';
import 'package:khalifa/src/qadaya/data/models/qadiya_model.dart';
import 'package:khalifa/src/qadaya/data/models/solution_model.dart';
import 'package:khalifa/src/qadaya/domain/entities/qadiya.dart';
import 'package:khalifa/src/qadaya/domain/entities/solution.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../../../../core/errors/failure.dart';

class QadayaRepositoryImplementation implements QadayaRepository {
  final QadayaLocalDataSource qadayaLocalDataSource;

  QadayaRepositoryImplementation(this.qadayaLocalDataSource);
  @override
  ResultFuture<void> createNewQadiya({required Qadiya qadiya}) async {
    try {
      final QadiyaModel qadiyaModel =
          QadiyaModel.convertToQadiyaModel(qadiyaModel: qadiya);
      await qadayaLocalDataSource.insertQadiya(qadiyaModel);
      return const Right(null);
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
  }

  @override
  ResultFuture<void> createNewSolution({
    required Qadiya qadiya,
    required Solution solution,
  }) async {
    try {
      final SolutionModel solutionModel =
          SolutionModel.convertSolutionToSolutionModel(solution: solution);
      await qadayaLocalDataSource.insertSolution(solution: solutionModel);
      return const Right(null);
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
  }

  @override
  ResultFuture<void> deleteQadiya({required Qadiya qadiya}) async {
    try {
      final QadiyaModel qadiyaModel =
          QadiyaModel.convertToQadiyaModel(qadiyaModel: qadiya);
      await qadayaLocalDataSource.deleteQadiya(qadiyaModel.qadiyaTitle);
      return const Right(null);
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
  }

  @override
  ResultFuture<void> deleteSolution({required Solution solution}) async {
    try {
      final SolutionModel solutionModel =
          SolutionModel.convertSolutionToSolutionModel(solution: solution);
      await qadayaLocalDataSource.deleteSolution(solutionModel.id);
      return const Right(null);
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
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
  }

  @override
  ResultFuture<List<Solution>?> getListOfAvailableSolutions({
    required Qadiya qadiya,
  }) async {
    try {
      final QadiyaModel qadiyaModel =
          QadiyaModel.convertToQadiyaModel(qadiyaModel: qadiya);
      final list = await qadayaLocalDataSource.getSolutions(
        qadiyaTitle: qadiyaModel.qadiyaTitle,
      );
      final List<Solution> convertedList = list != null
          ? SolutionModel.convertToListOfSolutions(solutions: list)
          : [];
      return Right(convertedList);
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
  }

  @override
  ResultFuture<void> saveLastEditedSolution({
    required Solution solution,
  }) async {
    try {
      final SolutionModel solutionModel =
          SolutionModel.convertSolutionToSolutionModel(solution: solution);
      await qadayaLocalDataSource.updateSolution(solutionModel);
      return const Right(null);
    } on Exception catch (e) {
      return Left(QadayaException.handleQadayaFailure(e));
    } catch (e) {
      return Left(QadayaException.handleQadayaObjectFailure(e));
    }
  }
}
