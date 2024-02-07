import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:khalifa/core/errors/failure.dart';
import 'package:khalifa/src/authentication/data/model/user_db.dart';
import 'package:khalifa/src/authentication/domain/usecases/create_user.dart';
import 'package:khalifa/src/authentication/domain/usecases/login.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc({
    required CreateUser createUser,
    required LogIn logIn,
  })  : _createUser = createUser,
        _logIn = logIn,
        super(const LocalAuthInitial()) {
    on<LocalAuthEventSignIn>(
      (event, emit) async {
        emit(const LocalAuthStateLoggedOut(isLoading: true, exception: null));
        final UserDB user = UserDB(
          userPassword: event.password,
          email: event.email,
        );
        final result = await _logIn.call(
          LogInParams(
            email: user.email,
            password: user.userPassword,
          ),
        );
        result.fold((error) {
          emit(
            LocalAuthStateLoggedOut(
              isLoading: false,
              exception: error,
            ),
          );
        }, (r) {
          if (r) {
            emit(
              LocalAuthStatLoggedIn(
                user: user,
                exception: null,
              ),
            );
          } else {
            emit(
              const LocalAuthStateLoggedOut(
                isLoading: false,
                exception: null,
              ),
            );
          }
        });
      },
    );
    on<LocalAuthEventSignUp>(
      (event, emit) async {
        emit(const LocalAuthStateLoggedOut(isLoading: true, exception: null));
        final UserDB user = UserDB(
          userPassword: event.password,
          email: event.email,
        );
        final result = await _createUser.call(
          CreateUserParams(
            email: user.email,
            password: user.userPassword,
          ),
        );
        result.fold((error) {
          emit(
            LocalAuthStateLoggedOut(
              isLoading: false,
              exception: error,
            ),
          );
        }, (r) {
          log("$r ");
          emit(
            LocalAuthStatLoggedIn(
              user: user,
              exception: null,
            ),
          );
        });
      },
    );
  }
  final CreateUser _createUser;
  final LogIn _logIn;
}
