import 'package:flutter/material.dart';
import 'package:khalifa/core/constant/phone/phone_size.dart';
import 'package:khalifa/core/enums/enum.dart';

import '../widgets/book_list.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: SizedBox(
          height: getScreenHeight(context) * .9,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "كتب سياسية",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const BookList(
                typeOfBooks: TypeOfBooks.politics,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "كتب تاريخية",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const BookList(
                typeOfBooks: TypeOfBooks.history,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
