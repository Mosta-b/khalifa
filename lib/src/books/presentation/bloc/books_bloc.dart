import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:khalifa/core/errors/failure.dart';
import 'package:khalifa/src/books/domain/usecases/get_all_books.dart';
import 'package:khalifa/src/books/domain/usecases/get_last_page_saved.dart';
import 'package:khalifa/src/books/domain/usecases/save_last_page.dart';

import '../../data/model/book_model.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc({
    required GetAllBooks getAllBooks,
    required GetLastPageSaved getLastPageSaved,
    required SaveLastBook saveLastBook,
  })  : _getAllBooks = getAllBooks,
        _getLastPageSaved = getLastPageSaved,
        _saveLastBook = saveLastBook,
        super(const BooksState(books: [], lastSavedPage: 0, loading: false)) {
    on<BooksEventGetAllBooks>((event, emit) async {
      emit(
        BooksState(
          books: state.books,
          lastSavedPage: state.lastSavedPage,
          loading: true,
        ),
      );
      // get all available list of pdf books
      final result = await _getAllBooks.call();
      result.fold((l) {
        emit(
          BooksState(
            books: state.books,
            lastSavedPage: state.lastSavedPage,
            loading: false,
            exception: l,
          ),
        );
      }, (resultList) {
        // convert to model books and emit state
        final convertedList =
            BookModel.convertListToBookModel(list: resultList);
        emit(
          BooksState(
            books: convertedList,
            lastSavedPage: state.lastSavedPage,
            loading: false,
          ),
        );
      });
    });
    on<BooksEventGetLastSavedPage>((event, emit) async {
      emit(
        BooksState(
          books: state.books,
          lastSavedPage: state.lastSavedPage,
          loading: true,
        ),
      );
      // get specific book last page
      final result = await _getLastPageSaved.call(
        GetLastPageSavedParams(bookName: event.bookName),
      );

      result.fold((l) {
        emit(
          BooksState(
            books: state.books,
            lastSavedPage: state.lastSavedPage,
            loading: false,
            exception: l,
          ),
        );
      }, (pageNumber) {
        emit(
          BooksState(
            books: state.books,
            lastSavedPage: pageNumber,
            loading: false,
          ),
        );
      });
    });
    on<BooksEventSaveLastPage>((event, emit) async {
      emit(
        BooksState(
          books: state.books,
          lastSavedPage: state.lastSavedPage,
          loading: true,
        ),
      );

      final result = await _saveLastBook.call(
        SaveLastBookParams(
          lastPage: event.lastPage,
          bookName: event.bookName,
        ),
      );

      result.fold((l) {
        emit(
          BooksState(
            books: state.books,
            lastSavedPage: state.lastSavedPage,
            loading: false,
            exception: l,
          ),
        );
      }, (r) {
        emit(
          BooksState(
            books: state.books,
            lastSavedPage: state.lastSavedPage,
            loading: true,
          ),
        );
      });
    });
  }
  final GetLastPageSaved _getLastPageSaved;
  final GetAllBooks _getAllBooks;
  final SaveLastBook _saveLastBook;
}
