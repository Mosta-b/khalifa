import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class Initialize extends InitializeUseCase {
  final AuthenticationRepository _repository;
  const Initialize(this._repository);

  @override
  ResultInitialize call() => _repository.initialize();
}
