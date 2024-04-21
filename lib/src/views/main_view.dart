import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _mainWidgetViews.elementAt(currentPage),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_3_fill),
              label: 'شخصيات',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar_today),
              label: 'تاريخ الهجري',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book_fill),
              label: 'المكتبة',
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIslamicIcons.solidCrescentMoon),
              label: 'الرئيسية',
              // backgroundColor: Colors.teal,
            ),
          ],
          currentIndex: currentPage,
          onTap: (value) {
            onItemTapped(index: value, context: context);
          },
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          elevation: 7,
        ),
      ),
    );
  }
}
