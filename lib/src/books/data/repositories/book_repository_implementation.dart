import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/books/domain/entities/book_entity.dart';
import 'package:khalifa/src/books/domain/repositories/books_repository.dart';

class BookRepositoryImplementation implements BooksRepository {
  @override
  ResultFuture<List<BookEntity>> getAllBooks() {
    // TODO: implement getAllBooks
    throw UnimplementedError();
  }

  @override
  ResultFuture<int> getLastPageSaved({required String bookName}) {
    // TODO: implement getLastPageSaved
    throw UnimplementedError();
  }
}
