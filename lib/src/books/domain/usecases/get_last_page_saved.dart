import 'package:khalifa/core/usecase/use_case.dart';
import 'package:khalifa/core/utils/typedef.dart';
import 'package:khalifa/src/books/domain/repositories/books_repository.dart';

class GetLastPageSaved extends UseCaseWithParams<int, GetLastPageSavedParams> {
  final BooksRepository _booksRepository;

  GetLastPageSaved(this._booksRepository);
  @override
  ResultFuture<int> call(GetLastPageSavedParams params) async =>
      await _booksRepository.getLastPageSaved(bookName: params.bookName);
}

class GetLastPageSavedParams {
  final String bookName;

  const GetLastPageSavedParams({required this.bookName});
}
