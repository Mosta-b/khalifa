import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:khalifa/src/books/data/model/book_model.dart';
import 'package:khalifa/src/books/presentation/bloc/books_bloc.dart';

class BookView extends StatefulWidget {
  final BookModel book;

  // final int lastPage;
  const BookView({
    Key? key,
    required this.book,
    // required this.lastPage,
  }) : super(key: key);

  @override
  BookViewState createState() => BookViewState();
}

class BookViewState extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    return PDFViewerFromAsset(
      book: widget.book,
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.book}) : super(key: key);
  final BookModel book;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (didPop) {},
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ'),
              actions: <Widget>[
                StreamBuilder<String>(
                    stream: _pageCountController.stream,
                    builder: (_, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                              // color: Colors.blue[900],
                            ),
                            child: Text(
                              snapshot.data!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
              ],
            ),
            body: PDF(
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: state.lastSavedPage,
              onPageChanged: (int? current, int? total) {
                _pageCountController.add('${current! + 1} - $total');
                context.read<BooksBloc>().add(
                      BooksEventSaveLastPage(
                        lastPage: current,
                        bookName: book.name,
                      ),
                    );
              },
              onViewCreated: (PDFViewController pdfViewController) async {
                _pdfViewController.complete(pdfViewController);
                final int currentPage = state.lastSavedPage;
                // final int currentPage =
                //     await pdfViewController.getCurrentPage() ?? 0;

                final int? pageCount = await pdfViewController.getPageCount();
                _pageCountController.add('${currentPage + 1} - $pageCount');
              },
            ).fromAsset(
              book.path,
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FutureBuilder<PDFViewController>(
              future: _pdfViewController.future,
              builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: '-',
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: const Center(
                            child: Icon(Icons.navigate_before_rounded)),
                        onPressed: () async {
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int currentPage =
                              (await pdfController.getCurrentPage())! - 1;
                          if (currentPage >= 0) {
                            await pdfController.setPage(currentPage);
                          }
                        },
                      ),
                      // AddWidth(width: 70),
                      FloatingActionButton(
                        heroTag: '+',
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: const Center(
                            child: Icon(Icons.navigate_next_rounded)),
                        onPressed: () async {
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int currentPage =
                              (await pdfController.getCurrentPage())! + 1;
                          final int numberOfPages =
                              await pdfController.getPageCount() ?? 0;
                          if (numberOfPages > currentPage) {
                            await pdfController.setPage(currentPage);
                          }
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }
}
