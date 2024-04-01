import 'package:get_it/get_it.dart';
import 'package:khalifa/src/authentication/data/datasource/authentication_biometrics_data_source.dart';
import 'package:khalifa/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:khalifa/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:khalifa/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:khalifa/src/authentication/domain/usecases/biometrics_auth.dart';
import 'package:khalifa/src/authentication/domain/usecases/create_user.dart';
import 'package:khalifa/src/authentication/domain/usecases/get_user.dart';
import 'package:khalifa/src/authentication/domain/usecases/login.dart';
import 'package:khalifa/src/authentication/presentation/bloc/local_auth_bloc.dart';
import 'package:khalifa/src/books/data/datasource/local_book_source.dart';
import 'package:khalifa/src/books/domain/repositories/books_repository.dart';
import 'package:khalifa/src/books/domain/usecases/get_all_books.dart';
import 'package:khalifa/src/books/domain/usecases/get_last_page_saved.dart';
import 'package:khalifa/src/books/domain/usecases/save_last_page.dart';
import 'package:khalifa/src/books/presentation/bloc/books_bloc.dart';

import '../../src/authentication/data/datasource/authentication_local_data_source.dart';
import '../../src/books/data/repositories/book_repository_implementation.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // register bloc
    ..registerFactory(
      () => LocalAuthBloc(
          createUser: sl(),
          logIn: sl(),
          getUser: sl(),
          requestBiometricsAuth: sl()),
    )
    // register usecase
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => LogIn(sl()))
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton(() => RequestBiometricsAuth(sl()))
    // repository
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(
              sl(),
              sl(),
              sl(),
            ))
    // remote data source
    ..registerLazySingleton<AuthnAuthenticationRemoteDataSourceContract>(
        () => AuthenticationRemoteDataSource())
    // local data source
    ..registerLazySingleton<LocalDataSource>(
        () => LocalDataBaseImplementation())
    ..registerLazySingleton<AuthenticationBiometricsDataSource>(
        () => AuthenticationBiometricsDataSourceImplementation());
  sl
    // register Bloc
    ..registerFactory(
      () => BooksBloc(
        getAllBooks: sl(),
        getLastPageSaved: sl(),
        saveLastBook: sl(),
      ),
    )
    // register usecase
    ..registerLazySingleton(() => GetAllBooks(sl()))
    ..registerLazySingleton(() => GetLastPageSaved(sl()))
    ..registerLazySingleton(() => SaveLastBook(sl()))
    // repository
    ..registerLazySingleton<BooksRepository>(
        () => BookRepositoryImplementation(localBookSource: sl()))
    // Data Source
    ..registerLazySingleton<LocalBookSource>(
        () => LocalBookSourceImplementation());
}
