import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/books/domain/repositories/books_repository.dart';

class SaveLastBook extends UseCaseWithParams<void, SaveLastBookParams> {
  final BooksRepository _booksRepository;

  SaveLastBook(this._booksRepository);
  @override
  ResultFuture<void> call(SaveLastBookParams params) async =>
      await _booksRepository.saveLastPage(
        lastPage: params.lastPage,
        bookName: params.bookName,
      );
}

class SaveLastBookParams {
  final int lastPage;
  final String bookName;

  const SaveLastBookParams({
    required this.lastPage,
    required this.bookName,
  });
}
