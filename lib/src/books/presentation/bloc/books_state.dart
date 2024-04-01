part of 'books_bloc.dart';

@immutable
class BooksState extends Equatable {
  final List<BookModel> books;
  final int lastSavedPage;

  final bool loading;

  final Failure? exception;

  const BooksState({
    required this.books,
    required this.lastSavedPage,
    required this.loading,
    this.exception,
  });

  @override
  List<Object?> get props => [books];
}
