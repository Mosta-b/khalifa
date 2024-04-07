import 'package:khalifa/core/enums/enum.dart';

import '../../src/books/data/model/book_model.dart';

class BooksTypes {
  static const List<String> listOfDeen = [
    "Quran",
    "God",
    "Prophetic",
    "Tafsir"
  ];
  static const List<String> listOfPolitics = ["Battle"];
  static const List<String> listOfHistory = ["History"];

  static bool checkIfIslamBook(String bookName) {
    for (String keyword in listOfDeen) {
      if (bookName.toLowerCase().contains(keyword.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  static bool checkIfPoliticsBook(String bookName) {
    for (String keyword in listOfPolitics) {
      if (bookName.toLowerCase().contains(keyword.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  static bool checkIfHistoryBook(String bookName) {
    for (String keyword in listOfHistory) {
      if (bookName.toLowerCase().contains(keyword.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  static int getNumberOfItemsInList({
    required List<BookModel> listToCheck,
    required TypeOfBooks typeOfBooks,
  }) {
    int num = 0;
    if (typeOfBooks == TypeOfBooks.islam) {
      for (BookModel book in listToCheck) {
        final checkForName = BooksTypes.checkIfIslamBook(book.name);
        if (checkForName) {
          num++;
        }
      }

      return num;
    } else if (typeOfBooks == TypeOfBooks.politics) {
      for (BookModel book in listToCheck) {
        final checkForName = BooksTypes.checkIfPoliticsBook(book.name);
        if (checkForName) {
          num++;
        }
      }
      return num;
    } else if (typeOfBooks == TypeOfBooks.history) {
      for (BookModel book in listToCheck) {
        final checkForName = BooksTypes.checkIfHistoryBook(book.name);
        if (checkForName) {
          num++;
        }
      }
      return num;
    } else {
      return listToCheck.length;
    }
  }

  static List<BookModel> getListOfBookTypes({
    required List<BookModel> listToCheck,
    required TypeOfBooks typeOfBooks,
  }) {
    List<BookModel> num = [];
    if (typeOfBooks == TypeOfBooks.islam) {
      for (BookModel book in listToCheck) {
        final checkForName = BooksTypes.checkIfIslamBook(book.name);
        if (checkForName) {
          num.add(book);
        }
      }

      return num;
    } else if (typeOfBooks == TypeOfBooks.politics) {
      for (BookModel book in listToCheck) {
        final checkForName = BooksTypes.checkIfPoliticsBook(book.name);
        if (checkForName) {
          num.add(book);
        }
      }
      return num;
    } else if (typeOfBooks == TypeOfBooks.history) {
      for (BookModel book in listToCheck) {
        final checkForName = BooksTypes.checkIfHistoryBook(book.name);
        if (checkForName) {
          num.add(book);
        }
      }
      return num;
    } else {
      return listToCheck;
    }
  }
}
