import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:khalifa/core/errors/failure.dart';
import 'package:khalifa/src/authentication/data/model/user_db.dart';
import 'package:khalifa/src/authentication/domain/usecases/biometrics_auth.dart';
import 'package:khalifa/src/authentication/domain/usecases/create_user.dart';
import 'package:khalifa/src/authentication/domain/usecases/get_user.dart';
import 'package:khalifa/src/authentication/domain/usecases/login.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc({
    required CreateUser createUser,
    required LogIn logIn,
    required GetUser getUser,
    required RequestBiometricsAuth requestBiometricsAuth,
  })  : _createUser = createUser,
        _logIn = logIn,
        _getUser = getUser,
        _requestBiometricsAuth = requestBiometricsAuth,
        super(const LocalAuthInitial()) {
    // TODO implement random check up after the user is retrieved
    on<LocalAuthEventGetUser>(
      (event, emit) async {
        emit(const LocalAuthInitial());

        final result = await _getUser();
        result.fold((error) {
          emit(LocalAuthStateLoggedOut(
            isLoading: false,
            exception: error,
          ));
        }, (r) {
          if (r) {
            const UserDB user = UserDB(
              userPassword: "ظهر الحق",
              email: "مصطفى",
            );
            add(const LocalAuthEventBiometricsAuth(user: user));
          } else {
            emit(const LocalAuthStateLoggedOut(
              isLoading: true,
              exception: null,
            ));
          }
        });
      },
    );
    on<LocalAuthEventBiometricsAuth>(
      (event, emit) async {
        final result = await _requestBiometricsAuth.call();
        result.fold((error) {
          emit(
            LocalAuthStateLoggedOut(
              isLoading: false,
              exception: error,
            ),
          );
        }, (r) {
          if (r) {
            final UserDB user = event.user;
            log("am pushing new state");
            emit(LocalAuthStatLoggedIn(
              user: user,
              exception: null,
            ));
          } else {
            emit(const LocalAuthStateLoggedOut(
              isLoading: false,
              exception: null,
            ));
          }
        });
      },
    );
    on<LocalAuthEventSignIn>(
      (event, emit) async {
        emit(const LocalAuthStateLoggedOut(
          isLoading: true,
          exception: null,
        ));
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
            add(LocalAuthEventBiometricsAuth(user: user));
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
        emit(const LocalAuthStateLoggedOut(
          isLoading: true,
          exception: null,
        ));
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
          add(LocalAuthEventBiometricsAuth(user: user));
        });
      },
    );
  }
  final CreateUser _createUser;
  final LogIn _logIn;
  final GetUser _getUser;

  final RequestBiometricsAuth _requestBiometricsAuth;
}
