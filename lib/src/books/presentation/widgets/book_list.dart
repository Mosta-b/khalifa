import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/services/classify_books.dart';
import '../../../../core/utils/get_book_cover_colors.dart';
import '../../data/model/book_model.dart';
import '../bloc/books_bloc.dart';
import 'book_card.dart';

class BookList extends StatelessWidget {
  final TypeOfBooks typeOfBooks;
  const BookList({
    super.key,
    required this.typeOfBooks,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, bookState) {
            if (typeOfBooks == TypeOfBooks.islam) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 11,
                  childAspectRatio: .8,
                ),
                reverse: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BooksTypes.getNumberOfItemsInList(
                  listToCheck: bookState.books,
                  typeOfBooks: TypeOfBooks.islam,
                ),
                itemBuilder: (context, index) {
                  BookModel book = BooksTypes.getListOfBookTypes(
                      listToCheck: bookState.books,
                      typeOfBooks: TypeOfBooks.islam)[index];
                  final checkForName = BooksTypes.checkIfIslamBook(book.name);
                  final Color coverColor =
                      getCoverColor(typeOfBooks: TypeOfBooks.islam);
                  if (checkForName) {
                    return BookCard(
                      bookModel: book,
                      bookCoverColor: coverColor,
                    );
                  }
                  return Container();
                },
              );
            } else if (typeOfBooks == TypeOfBooks.politics) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 11,
                  childAspectRatio: .7,
                ),
                shrinkWrap: true,
                reverse: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BooksTypes.getNumberOfItemsInList(
                  listToCheck: bookState.books,
                  typeOfBooks: TypeOfBooks.politics,
                ),
                itemBuilder: (context, index) {
                  BookModel book = BooksTypes.getListOfBookTypes(
                    listToCheck: bookState.books,
                    typeOfBooks: TypeOfBooks.politics,
                  )[index];
                  final checkForName =
                      BooksTypes.checkIfPoliticsBook(book.name);
                  final Color coverColor =
                      getCoverColor(typeOfBooks: TypeOfBooks.politics);
                  if (checkForName) {
                    return BookCard(
                      bookModel: book,
                      bookCoverColor: coverColor,
                    );
                  }
                  return Container();
                },
              );
            } else if (typeOfBooks == TypeOfBooks.history) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 11,
                  childAspectRatio: .7,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BooksTypes.getNumberOfItemsInList(
                  listToCheck: bookState.books,
                  typeOfBooks: TypeOfBooks.history,
                ),
                itemBuilder: (context, index) {
                  BookModel book = BooksTypes.getListOfBookTypes(
                    listToCheck: bookState.books,
                    typeOfBooks: TypeOfBooks.history,
                  )[index];
                  final checkForName = BooksTypes.checkIfHistoryBook(book.name);
                  final Color coverColor =
                      getCoverColor(typeOfBooks: TypeOfBooks.history);
                  if (checkForName) {
                    return BookCard(
                      bookModel: book,
                      bookCoverColor: coverColor,
                    );
                  }
                  return Container();
                },
              );
            } else {
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: bookState.books.length,
                itemBuilder: (context, index) {
                  final BookModel book = bookState.books[index];
                  final Color coverColor =
                      getCoverColor(typeOfBooks: TypeOfBooks.all);
                  return BookCard(
                    bookModel: book,
                    bookCoverColor: coverColor,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
