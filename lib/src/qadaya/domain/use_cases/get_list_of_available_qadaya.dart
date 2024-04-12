import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../entities/qadiya.dart';

class GetListOfAvailableQadaya extends UseCaseWithoutParams<List<Qadiya>?> {
  final QadayaRepository _qadayaRepository;

  GetListOfAvailableQadaya(this._qadayaRepository);
  @override
  ResultFuture<List<Qadiya>?> call() async =>
      await _qadayaRepository.getListOfAvailableQadaya();
}
