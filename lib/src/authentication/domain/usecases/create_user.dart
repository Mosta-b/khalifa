import 'package:equatable/equatable.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<int, CreateUserParams> {
  final AuthenticationRepository _repository;

  CreateUser(this._repository);

  @override
  ResultFuture<int> call(CreateUserParams params) async =>
      _repository.createUser(
        email: params.email,
        password: params.password,
      );
}

class CreateUserParams extends Equatable {
  final String email;
  final String password;

  const CreateUserParams({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}
