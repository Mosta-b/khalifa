import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/books/domain/entities/book_entity.dart';
import 'package:khalifa/src/books/domain/repositories/books_repository.dart';

class GetAllBooks extends UseCaseWithoutParams<List<BookEntity>> {
  final BooksRepository booksRepository;

  GetAllBooks(this.booksRepository);
  @override
  ResultFuture<List<BookEntity>> call() async =>
      await booksRepository.getAllBooks();
}
