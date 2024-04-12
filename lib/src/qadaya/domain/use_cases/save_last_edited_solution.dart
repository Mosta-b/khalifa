import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../entities/solution.dart';

class SaveLastEditedSolution
    extends UseCaseWithParams<void, SaveLastEditedSolutionParams> {
  final QadayaRepository _qadayaRepository;

  SaveLastEditedSolution(this._qadayaRepository);
  @override
  ResultFuture<void> call(SaveLastEditedSolutionParams params) async =>
      await _qadayaRepository.saveLastEditedSolution(solution: params.solution);
}

class SaveLastEditedSolutionParams {
  final Solution solution;

  const SaveLastEditedSolutionParams({required this.solution});
}
