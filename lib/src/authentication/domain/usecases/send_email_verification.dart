import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class SendEmailVerification extends UseCaseWithoutParams<void> {
  final AuthenticationRepository _repository;
  const SendEmailVerification(this._repository);

  @override
  ResultVoid call() async => _repository.sendEmailVerification();
}
