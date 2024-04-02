import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalifa/src/books/data/model/book_model.dart';
import 'package:khalifa/src/books/presentation/views/book_view.dart';

import '../../../../core/utils/get_book_cover_colors.dart';
import '../bloc/books_bloc.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;
  const BookCard({Key? key, required this.bookModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
      child: SizedBox(
        width: 100,
        // height: 100,
        child: Card(
          color: getCoverColor(),
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
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
