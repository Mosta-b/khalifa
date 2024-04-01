import 'package:dartz/dartz.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/books/data/datasource/local_book_source.dart';
import 'package:khalifa/src/books/data/model/book_model.dart';
import 'package:khalifa/src/books/domain/entities/book_entity.dart';
import 'package:khalifa/src/books/domain/repositories/books_repository.dart';

import '../../../../core/errors/failure.dart';

class BookRepositoryImplementation implements BooksRepository {
  final LocalBookSource _localBookSource;

  BookRepositoryImplementation({required LocalBookSource localBookSource})
      : _localBookSource = localBookSource;
  @override
  ResultFuture<List<BookEntity>> getAllBooks() async {
    try {
      final List<BookModel> theListToConvert =
          await _localBookSource.getAllBooks();
      final List<BookEntity> finalList =
          BookModel.convertListToBookEntity(list: theListToConvert);
      return Right(finalList);
    } on Exception catch (e) {
      return Left(LocalBooksDataBaseFailure.handleLocalBooksDataBaseFailure(e));
    } catch (e) {
      return Left(
          LocalBooksDataBaseFailure.handleLocalBooksDataBaseObjectFailure(e));
    }
  }

  @override
  ResultFuture<int> getLastPageSaved({required String bookName}) async {
    try {
      final int theListToConvert =
          await _localBookSource.getLastPageSaved(bookName: bookName);

      return Right(theListToConvert);
    } on Exception catch (e) {
      return Left(LocalBooksDataBaseFailure.handleLocalBooksDataBaseFailure(e));
    } catch (e) {
      return Left(
          LocalBooksDataBaseFailure.handleLocalBooksDataBaseObjectFailure(e));
    }
  }

  @override
  ResultFuture<void> saveLastPage({
    required int lastPage,
    required String bookName,
  }) async {
    try {
      await _localBookSource.saveLastPage(
          bookName: bookName, lastPage: lastPage);

      return const Right(null);
    } on Exception catch (e) {
      return Left(LocalBooksDataBaseFailure.handleLocalBooksDataBaseFailure(e));
    } catch (e) {
      return Left(
          LocalBooksDataBaseFailure.handleLocalBooksDataBaseObjectFailure(e));
    }
  }
}
