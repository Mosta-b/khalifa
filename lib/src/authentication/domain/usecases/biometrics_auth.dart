import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/authentication/domain/repositories/authentication_repository.dart';

class RequestBiometricsAuth extends UseCaseWithoutParams<bool> {
  const RequestBiometricsAuth(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<bool> call() async =>
      await _authenticationRepository.requestBiometricsAuth();
}
