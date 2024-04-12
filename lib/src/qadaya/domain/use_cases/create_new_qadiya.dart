import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../entities/qadiya.dart';

class CreateNewQadiya extends UseCaseWithParams<void, CreateNewQadiyaParams> {
  final QadayaRepository _qadayaRepository;

  CreateNewQadiya(this._qadayaRepository);
  @override
  ResultFuture<void> call(CreateNewQadiyaParams params) async =>
      await _qadayaRepository.createNewQadiya(qadiya: params.qadiya);
}

class CreateNewQadiyaParams {
  final Qadiya qadiya;

  const CreateNewQadiyaParams({required this.qadiya});
}
