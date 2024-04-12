import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/qadaya/domain/repositories/qadaya_repository.dart';

import '../entities/qadiya.dart';

class DeleteQadiya extends UseCaseWithParams<void, DeleteQadiyaParams> {
  final QadayaRepository _qadayaRepository;

  DeleteQadiya(this._qadayaRepository);
  @override
  ResultFuture<void> call(DeleteQadiyaParams params) async =>
      await _qadayaRepository.deleteQadiya(qadiya: params.qadiya);
}

class DeleteQadiyaParams {
  final Qadiya qadiya;

  const DeleteQadiyaParams({required this.qadiya});
}
