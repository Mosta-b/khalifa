import '../../../../core/utils/typedef.dart';
import '../../data/model/user_model.dart';

abstract class AuthenticationRepository {
  ResultInitialize initialize();
  UserModel? get currentUser;
  ResultVoid createUser({
    required String userName,
    required String email,
    required String password,
  });

  ResultVoid signInWithGoogle();

  ResultFuture<bool> logIn({
    required String email,
    required String password,
  });

  ResultVoid signOut();

  ResultVoid sendEmailVerification();

  ResultFuture<UserModel> updatingUser({
    String? userName,
    String? email,
  });
}
