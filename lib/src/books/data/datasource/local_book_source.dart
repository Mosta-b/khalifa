import 'dart:developer';
import 'dart:io';

import 'package:khalifa/src/books/data/model/book_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalBookSource {
  Future<SharedPreferences> get prefs;
  Future<List<BookModel>> getAllBooks();

  Future<int> getLastPageSaved({required String bookName});
  Future<void> saveLastPage({required int lastPage, required String bookName});
}

class LocalBookSourceImplementation implements LocalBookSource {
  @override
  Future<List<BookModel>> getAllBooks() async {
    List<BookModel> pdfBooks = [];
    // Get the application documents directory
    Directory directory = await getApplicationDocumentsDirectory();
    // Create a Directory object for the books directory
    Directory booksDirectory = Directory('${directory.path}/assets/books');
    if (booksDirectory.existsSync()) {
      List<FileSystemEntity> files = directory.listSync(recursive: false);
      for (FileSystemEntity file in files) {
        if (file is File && file.path.toLowerCase().endsWith('.pdf')) {
          String fileName =
              file.path.split('/').last; // Extracting the file name
          log("name = $fileName path = ${file.path} => File name and path");
          pdfBooks.add(BookModel(name: fileName, path: file.path));
        }
      }
    }

    return pdfBooks;
  }

  @override
  Future<int> getLastPageSaved({required String bookName}) async {
    final pref = await prefs;
    final int? counter = pref.getInt(bookName);
    return counter ?? 0;
  }

  @override
  Future<void> saveLastPage({
    required int lastPage,
    required String bookName,
  }) async {
    final pref = await prefs;
    await pref.setInt(bookName, lastPage);
  }

  @override
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
}
