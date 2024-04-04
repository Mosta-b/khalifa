import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/enum.dart';
import '../../../../core/services/classifey_books.dart';
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
    return SizedBox(
      height: 170,
      child: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, bookState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: bookState.books.length,
            itemBuilder: (context, index) {
              final BookModel book = bookState.books[index];
              if (typeOfBooks == TypeOfBooks.islam) {
                log("already here");
                final checkForName = BooksTypes.checkIfIslamBook(book.name);
                if (checkForName) {
                  log("$checkForName checking");
                  return BookCard(
                    bookModel: book,
                  );
                }
              } else if (typeOfBooks == TypeOfBooks.history) {
              } else if (typeOfBooks == TypeOfBooks.politics) {
              } else {
                return BookCard(
                  bookModel: book,
                );
              }
            },
          );
        },
      ),
    );
  }
}
