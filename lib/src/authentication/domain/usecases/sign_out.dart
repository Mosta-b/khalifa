import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class SignOut extends UseCaseWithoutParams<void> {
  final AuthenticationRepository _repository;
  const SignOut(this._repository);

  @override
  ResultVoid call() async => _repository.signOut();
}
