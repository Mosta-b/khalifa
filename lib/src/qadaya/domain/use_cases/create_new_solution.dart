import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../entities/qadiya.dart';
import '../entities/solution.dart';

class CreateNewSolution
    extends UseCaseWithParams<void, CreateNewSolutionParams> {
  final QadayaRepository _qadayaRepository;

  CreateNewSolution(this._qadayaRepository);
  @override
  ResultFuture<void> call(CreateNewSolutionParams params) async =>
      _qadayaRepository.createNewSolution(
          qadiya: params.qadiya, solution: params.solution);
}

class CreateNewSolutionParams {
  final Qadiya qadiya;
  final Solution solution;

  const CreateNewSolutionParams({
    required this.qadiya,
    required this.solution,
  });
}
