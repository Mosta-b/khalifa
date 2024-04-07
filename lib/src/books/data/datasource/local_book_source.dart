import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:khalifa/src/books/data/model/book_model.dart';
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
    // Load the list of assets from the AssetManifest.json file
    List<String> assetFiles = await rootBundle
        .loadString('AssetManifest.json')
        .then((String jsonString) {
      Map<String, dynamic> manifest = json.decode(jsonString);
      return manifest.keys
          .where((String key) =>
              key.startsWith('assets/books/') &&
                  key.toLowerCase().endsWith('.pdf') ||
              key.toLowerCase().startsWith('pdf.'))
          .toList();
    });

    // Extract the file name and path for each PDF asset file
    for (String assetFile in assetFiles) {
      String fileName =
          BookModel.getName(assetFile.split('/').last.replaceAll('.pdf', ""));

      pdfBooks.add(BookModel(name: fileName, path: assetFile));
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
