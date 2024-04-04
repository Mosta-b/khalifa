import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int currentIndex = 3;

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

void onItemTapped({required int index, required BuildContext context}) {
  Provider.of<BottomNavBarProvider>(context, listen: false).changePage(index);
}
