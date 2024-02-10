import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';

import '../repositories/authentication_repository.dart';

class GetUser extends UseCaseWithoutParams<bool> {
  final AuthenticationRepository authenticationRepository;

  GetUser(this.authenticationRepository);
  @override
  ResultFuture<bool> call() => authenticationRepository.getUser();
}
