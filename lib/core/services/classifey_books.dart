import 'dart:developer';

class BooksTypes {
  static const List<String> listOfDeen = ["Quran", "God", "Prophetic"];

  static bool checkIfIslamBook(String bookName) {
    log(bookName.split(" ").contains(listOfDeen).toString());
    log(bookName.split(" ").toString());
    return bookName.split(" ").contains(listOfDeen);
  }
}
