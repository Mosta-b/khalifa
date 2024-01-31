import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class SignInWithGoogle extends UseCaseWithoutParams<void> {
  final AuthenticationRepository _repository;
  const SignInWithGoogle(this._repository);
  @override
  ResultFuture<void> call() async => _repository.signInWithGoogle();
}
