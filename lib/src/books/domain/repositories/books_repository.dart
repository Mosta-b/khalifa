import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/books/domain/entities/book_entity.dart';

abstract class BooksRepository {
  ResultFuture<List<BookEntity>> getAllBooks();

  ResultFuture<int> getLastPageSaved({required String bookName});
}
