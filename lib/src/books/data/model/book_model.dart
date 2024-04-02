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

  static List<BookEntity> convertListToBookEntity({
    required List<BookModel> list,
  }) {
    List<BookEntity> listToConvert = [];
    for (BookModel bookModel in list) {
      listToConvert.add(BookEntity(name: bookModel.name, path: bookModel.path));
    }
    return listToConvert;
  }

  static List<BookModel> convertListToBookModel({
    required List<BookEntity> list,
  }) {
    final List<BookModel> listToConvert = [];
    for (BookEntity bookEntity in list) {
      listToConvert
          .add(BookModel(name: bookEntity.name, path: bookEntity.path));
    }
    return listToConvert;
  }

  String getPath() {
    const String globalPath = "assets/books/";
    return "$globalPath$path";
  }

  static String getName(String underscoreName) {
    return underscoreName.replaceAll("_", " ");
  }
}
