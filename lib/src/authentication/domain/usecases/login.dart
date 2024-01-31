import 'package:equatable/equatable.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class LogIn extends UseCaseWithParams<bool, LogInParams> {
  final AuthenticationRepository _repository;
  const LogIn(this._repository);

  @override
  ResultFuture<bool> call(LogInParams params) async => _repository.logIn(
        email: params.email,
        password: params.password,
      );
}

class LogInParams extends Equatable {
  final String email;
  final String password;

  const LogInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email];
}
