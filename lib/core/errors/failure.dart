import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_exceptions.dart';
import 'book_exception.dart';

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

class LocalBooksDataBaseFailure extends Failure {
  const LocalBooksDataBaseFailure({
    required super.message,
    required super.exception,
  });

  static Failure handleLocalBooksDataBaseFailure(Exception exception) {
    return LocalBooksDataBaseFailure(
        message: "Local Books Data Base Error", exception: exception);
  }

  static Failure handleLocalBooksDataBaseObjectFailure(Object exception) {
    return LocalBooksDataBaseFailure(
      message: "Local Books Data Base Object Error => $exception ",
      exception: BooksGenericException(),
    );
  }
}

class LocalDataBaseFailure extends Failure {
  const LocalDataBaseFailure({
    required super.message,
    required super.exception,
  });
  static Failure handleLocalDataBaseFailure(Exception exception) {
    log('$exception => LocalDataBaseFailure exception');
    return LocalDataBaseFailure(exception: exception, message: 'sqlite Error');
  }

  static Failure handleLocalDataBaseObjectFailure(Object exception) {
    log('$exception => LocalDataBaseFailure Object');
    return LocalDataBaseFailure(
        exception: Exception(), message: 'sqlite Error');
  }
}
