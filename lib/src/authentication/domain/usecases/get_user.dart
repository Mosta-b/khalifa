import '../../data/model/user_model.dart';
import '../repositories/authentication_repository.dart';

class GetUser {
  final AuthenticationRepository _repository;
  const GetUser(this._repository);

  UserModel? call() => _repository.currentUser;
}
