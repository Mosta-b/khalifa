import 'package:flutter/material.dart';
import 'package:khalifa/core/enums/enum.dart';

import '../../books/presentation/widgets/book_list.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "كتب دينية",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const BookList(
              typeOfBooks: TypeOfBooks.islam,
            ),
          ],
        ),
      ),
    );
  }
}
