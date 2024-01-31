import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasource/authentication_remote_data_source.dart';
import '../model/user_model.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  final AuthnAuthenticationRemoteDataSourceContract _remoteDataSource;
  @override
  UserModel? get currentUser => _remoteDataSource.getUser();

  @override
  ResultInitialize initialize() async {
    await _remoteDataSource.initialize();
    await _remoteDataSource.reload();
    final user = await _remoteDataSource.getUser();
    if (user != null) {
      return Right(user);
    } else {
      return const Left(null);
    }
  }

  @override
  ResultVoid createUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      //first create user with non verified email and password
      await _remoteDataSource.createUser(
        email: email,
        password: password,
      );
      // give it a display name
      _remoteDataSource.updateUserName(displayName: userName);
      return const Right(null);
    } on Exception catch (e) {
      return Left(FirebaseFailure.handleFirebaseException(e));
    }
  }

// log in with email and password
  @override
  ResultFuture<bool> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _remoteDataSource.logIn(email: email, password: password);
      return Right(result);
    } on Exception catch (e) {
      return Left(FirebaseFailure.handleFirebaseException(e));
    }
  }

// to log out
  @override
  ResultVoid signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on Exception catch (e) {
      return Left(FirebaseFailure.handleFirebaseException(e));
    }
  }

// password rest

// send email verification
  @override
  ResultVoid sendEmailVerification() async {
    try {
      await _remoteDataSource.sendEmailVerification();
      return const Right(null);
    } on Exception catch (e) {
      return Left(FirebaseFailure.handleFirebaseException(e));
    }
  }

// sign with google
  @override
  ResultVoid signInWithGoogle() async {
    try {
      await _remoteDataSource.signInWithGoogle();
      return const Right(null);
    } on Exception catch (e) {
      return Left(FirebaseFailure.handleFirebaseException(e));
    }
  }

  @override
  ResultFuture<UserModel> updatingUser(
      {String? userName, String? email}) async {
    final UserModel user = _remoteDataSource.getUser();
    try {
      if (userName != null && user.userName != userName) {
        await _remoteDataSource.updateUserName(displayName: userName);
      }
      if (email != null && user.email != email) {
        await _remoteDataSource.updateUserEmail(email: email);
      }
      _remoteDataSource.getUser;
      final newUser = _remoteDataSource.getUser();
      return Right(newUser);
    } on Exception catch (e) {
      return Left(FirebaseFailure.handleFirebaseException(e));
    }
  }
}
