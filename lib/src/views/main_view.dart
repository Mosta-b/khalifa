import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation/chat_gpt.dart';
import 'bottom_navigation/home_view.dart';
import 'bottom_navigation/libary.dart';
import 'bottom_navigation/quran.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _page = 3;

  static const List<Widget> _mainWidgetViews = [
    ChatGpt(),
    Quran(),
    Library(),
    HomeView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Center(
        child: _mainWidgetViews.elementAt(_page),
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
        currentIndex: _page,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 7,
      ),
    );
  }
}
