part of 'local_auth_bloc.dart';

@immutable
class LocalAuthState extends Equatable {
  final bool isLoading;
  final Failure? exception;
  const LocalAuthState({required this.isLoading, required this.exception});

  @override
  List<Object?> get props => [isLoading, exception];
}

class LocalAuthInitial extends LocalAuthState {
  const LocalAuthInitial() : super(isLoading: false, exception: null);
}

class LocalAuthStatLoggedIn extends LocalAuthState {
  final UserDB user;

  const LocalAuthStatLoggedIn({
    required this.user,
    bool? isLoading,
    required Failure? exception,
  }) : super(
          isLoading: isLoading ?? false,
          exception: exception,
        );
}

class LocalAuthStateLoggedOut extends LocalAuthState {
  const LocalAuthStateLoggedOut({
    required bool? isLoading,
    required Failure? exception,
  }) : super(
          isLoading: isLoading ?? false,
          exception: exception,
        );
}
