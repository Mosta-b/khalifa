import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalifa/src/books/data/model/book_model.dart';
import 'package:khalifa/src/books/presentation/views/book_view.dart';

import '../bloc/books_bloc.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;
  final Color bookCoverColor;
  const BookCard({
    Key? key,
    required this.bookModel,
    required this.bookCoverColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        color: bookCoverColor,
        child: InkWell(
          onTap: () {
            context.read<BooksBloc>().add(
                  BooksEventGetLastSavedPage(
                    bookName: bookModel.name,
                  ),
                );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookView(
                  book: bookModel,
                ),
              ),
            );
          },
          child: Center(
            child: Text(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              bookModel.name,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
