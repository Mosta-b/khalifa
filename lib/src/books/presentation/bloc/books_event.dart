part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {
  const BooksEvent();
}

class BooksEventGetAllBooks extends BooksEvent {}

class BooksEventGetLastSavedPage extends BooksEvent {
  final String bookName;

  const BooksEventGetLastSavedPage({
    required this.bookName,
  });
}

class BooksEventSaveLastPage extends BooksEvent {
  final int lastPage;
  final String bookName;

  const BooksEventSaveLastPage({
    required this.lastPage,
    required this.bookName,
  });
}
