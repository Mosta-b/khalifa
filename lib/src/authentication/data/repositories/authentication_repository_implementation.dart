import 'package:dartz/dartz.dart';
import 'package:khalifa/src/authentication/data/model/user_db.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasource/authentication_local_data_source.dart';
import '../datasource/authentication_remote_data_source.dart';
import '../model/user_model.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(
    this._remoteDataSource,
    this._localDataSource,
  );
  final AuthnAuthenticationRemoteDataSourceContract _remoteDataSource;
  final LocalDataSource _localDataSource;
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
  ResultFuture<int> createUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserDB user = UserDB(userPassword: password, email: email);
      final int number = await _localDataSource.signUp(user);
      return Right(number);
    } on Exception catch (e) {
      return Left(LocalDataBaseFailure.handleLocalDataBaseFailure(e));
    } catch (e) {
      return Left(LocalDataBaseFailure.handleLocalDataBaseObjectFailure(e));
    }
  }

// log in with email and password
  @override
  ResultFuture<bool> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserDB user = UserDB(userPassword: password, email: email);
      final result = await _localDataSource.signIn(user);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalDataBaseFailure.handleLocalDataBaseFailure(e));
    } catch (e) {
      return Left(LocalDataBaseFailure.handleLocalDataBaseObjectFailure(e));
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
