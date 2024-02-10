part of 'local_auth_bloc.dart';

@immutable
abstract class LocalAuthEvent {
  const LocalAuthEvent();
}

class LocalAuthEventGetUser extends LocalAuthEvent {
  const LocalAuthEventGetUser();
}

class LocalAuthEventBiometricsAuth extends LocalAuthEvent {
  const LocalAuthEventBiometricsAuth({required this.user});
  final UserDB user;
}

class LocalAuthEventSignIn extends LocalAuthEvent {
  const LocalAuthEventSignIn({required this.email, required this.password});
  final String email;
  final String password;
}

class LocalAuthEventSignUp extends LocalAuthEvent {
  const LocalAuthEventSignUp({required this.email, required this.password});
  final String email;
  final String password;
}
