import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../entities/solution.dart';

class DeleteSolution extends UseCaseWithParams<void, DeleteSolutionParams> {
  final QadayaRepository _qadayaRepository;

  DeleteSolution(this._qadayaRepository);
  @override
  ResultFuture<void> call(DeleteSolutionParams params) async =>
      await _qadayaRepository.deleteSolution(solution: params.solution);
}

class DeleteSolutionParams {
  final Solution solution;

  const DeleteSolutionParams({required this.solution});
}
