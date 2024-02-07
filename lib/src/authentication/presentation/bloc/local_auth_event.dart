part of 'local_auth_bloc.dart';

@immutable
abstract class LocalAuthEvent {
  const LocalAuthEvent();
}

class LocalAuthEventSignIn extends LocalAuthEvent {
  final String email;
  final String password;

  const LocalAuthEventSignIn({required this.email, required this.password});
}

class LocalAuthEventSignUp extends LocalAuthEvent {
  final String email;
  final String password;

  const LocalAuthEventSignUp({required this.email, required this.password});
}
