import 'package:khalifa/src/books/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required super.name,
    required super.path,
  });

  BookEntity convertToBookEntity() {
    return BookEntity(name: name, path: path);
  }

  static BookModel convertToBookModel({required BookEntity bookEntity}) {
    return BookModel(
      name: bookEntity.name,
      path: bookEntity.path,
    );
  }

  static List<BookEntity> convertListToBookEntity(
      {required List<BookModel> list}) {
    final List<BookEntity> listToConvert = [];
    for (var i = 0; i <= list.length; i++) {
      listToConvert.add(BookEntity(name: list[i].name, path: list[i].path));
    }
    return listToConvert;
  }

  static List<BookModel> convertListToBookModel(
      {required List<BookEntity> list}) {
    final List<BookModel> listToConvert = [];
    for (var i = 0; i <= list.length; i++) {
      listToConvert.add(BookModel(name: list[i].name, path: list[i].path));
    }
    return listToConvert;
  }

  String getPath() {
    const String globalPath = "assets/books/";
    return "$globalPath$path";
  }

  String getName(String underscoreName) {
    return underscoreName.replaceAll("_", " ");
  }
}
