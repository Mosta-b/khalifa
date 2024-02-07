import 'package:get_it/get_it.dart';
import 'package:khalifa/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:khalifa/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:khalifa/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:khalifa/src/authentication/domain/usecases/create_user.dart';
import 'package:khalifa/src/authentication/domain/usecases/login.dart';
import 'package:khalifa/src/authentication/presentation/bloc/local_auth_bloc.dart';

import '../../src/authentication/data/datasource/authentication_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // register bloc
    ..registerFactory(() => LocalAuthBloc(
          createUser: sl(),
          logIn: sl(),
        ))
    // register usecase
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => LogIn(sl()))
    // repository
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(
              sl(),
              sl(),
            ))
    // remote data source
    ..registerLazySingleton<AuthnAuthenticationRemoteDataSourceContract>(
        () => AuthenticationRemoteDataSource())
    // local data source
    ..registerLazySingleton<LocalDataSource>(
        () => LocalDataBaseImplementation());
}
