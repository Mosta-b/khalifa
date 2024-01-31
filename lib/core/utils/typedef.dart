import 'package:dartz/dartz.dart' show Either;

import '../../src/authentication/data/model/user_model.dart';
import '../errors/failure.dart' show Failure;

// Result typedef
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultInitialize = Future<Either<void, UserModel>>;
typedef ResultVoid = ResultFuture<void>;
