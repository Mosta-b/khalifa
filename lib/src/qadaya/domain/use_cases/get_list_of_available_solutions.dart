import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/entities/qadiya.dart';
import 'package:khalifa/src/qadaya/domain/entities/solution.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

class GetListOfAvailableSolutions extends UseCaseWithParams<List<Solution>?,
    GetListOfAvailableSolutionsParams> {
  final QadayaRepository _qadayaRepository;

  GetListOfAvailableSolutions(this._qadayaRepository);
  @override
  ResultFuture<List<Solution>?> call(
          GetListOfAvailableSolutionsParams params) async =>
      await _qadayaRepository.getListOfAvailableSolutions(
        qadiya: params.qadiya,
      );
}

class GetListOfAvailableSolutionsParams {
  final Qadiya qadiya;

  const GetListOfAvailableSolutionsParams({
    required this.qadiya,
  });
}
