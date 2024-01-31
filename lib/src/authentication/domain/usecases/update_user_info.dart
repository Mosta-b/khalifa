import 'package:equatable/equatable.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/model/user_model.dart';
import '../repositories/authentication_repository.dart';

class UpdateUserInfo
    extends UseCaseWithParams<UserModel, UpdateUserInfoParams> {
  final AuthenticationRepository _repository;
  const UpdateUserInfo(this._repository);
  @override
  ResultFuture<UserModel> call(UpdateUserInfoParams params) async =>
      _repository.updatingUser(
        email: params.email,
        userName: params.userName,
      );
}

class UpdateUserInfoParams extends Equatable {
  final String? userName;
  final String? email;

  const UpdateUserInfoParams({
    required this.userName,
    required this.email,
  });
  @override
  List<Object?> get props => [userName, email];
}
