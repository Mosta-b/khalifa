import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/extensions/bottom_navigation_bar_provider.dart';
import '../books/presentation/views/libary.dart';
import 'bottom_navigation/chat_gpt.dart';
import 'bottom_navigation/home_view.dart';
import 'bottom_navigation/quran.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  // int _page = 3;

  static const List<Widget> _mainWidgetViews = [
    ChatGpt(),
    Quran(),
    Library(),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    final int currentPage =
        Provider.of<BottomNavBarProvider>(context).currentIndex;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Center(
        child: _mainWidgetViews.elementAt(currentPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.device_laptop),
            label: 'الذكاء الاصطناعي',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_circle_fill),
            label: 'المصحف',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_fill),
            label: 'المكتبة',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'الرئسية',
          ),
        ],
        currentIndex: currentPage,
        onTap: (value) {
          onItemTapped(index: value, context: context);
        },
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 7,
      ),
    );
  }
}
