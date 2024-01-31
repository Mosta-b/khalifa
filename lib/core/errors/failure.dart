import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_exceptions.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;
  final Exception exception;

  const Failure({required this.message, required this.exception});
  @override
  List<Object> get props => [message, exception];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({
    required super.message,
    required super.exception,
  });
// FirebaseFailure manager to handle different Firebase auth Exceptions
  static Failure handleFirebaseException(Exception exception) {
    if (exception is FirebaseAuthException) {
      log('$exception => Printed at FirebaseFailure in ${DateTime.now()} => 1');
      switch (exception.code) {
        case 'user-not-found':
          return FirebaseFailure(
              exception: UserDoesNotExistAuthException(),
              message: 'User not found');
        case 'invalid-phone-number':
          return FirebaseFailure(
              exception: PhoneNumberInvalidAuthException(),
              message: 'Phone in Wrong format');
        case 'invalid-verification-code':
          return FirebaseFailure(
              exception: InvalidSmsCodeAuthException(),
              message: 'Wrong sms code');
        case 'email-already-in-use':
          return FirebaseFailure(
              exception: EmailAlreadyInUseAuthException(),
              message: 'email already in use');
        case 'credential-already-in-use':
          return FirebaseFailure(
              exception: PhoneNumberAlreadyInUseException(),
              message: 'number already in use');
        case 'weak-password':
          return FirebaseFailure(
              exception: WeakPasswordAuthException(), message: 'weak code');
        case 'user-disabled':
          return FirebaseFailure(
              exception: UserDisabledAuthException(), message: 'User banned');
        case 'wrong-password':
          return FirebaseFailure(
              exception: InvalidCredentialsAuthException(),
              message: 'wrong password');
        case 'requires-recent-login':
          return FirebaseFailure(
              exception: RequireRecentLogIn(),
              message: 'requires recent login');
        case 'invalid-email':
          return FirebaseFailure(
              exception: InvalidEmailAuthException(), message: 'invalid email');
        default:
          return FirebaseFailure(
              exception: GenericAuthException(), message: 'Error has occurred');
      }
    } else {
      log('$exception => debugPrinted at FirebaseFailure in ${DateTime.now()} => 2');
      return FirebaseFailure(
          exception: GenericAuthException(), message: 'Error has occurred');
    }
  }
}

class RemoteCloudFailure extends Failure {
  const RemoteCloudFailure({
    required super.message,
    required super.exception,
  });
  static Failure handleRemoteCloudFailure(Exception exception) {
    log('$exception => RemoteCloudFailure');
    return RemoteCloudFailure(exception: Exception(), message: 'Cloud Error');
  }
}
