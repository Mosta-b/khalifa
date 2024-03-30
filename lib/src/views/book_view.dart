import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  final String bookName;
  const BookView({
    Key? key,
    required this.bookName,
  }) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
