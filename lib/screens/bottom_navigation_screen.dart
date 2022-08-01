import 'package:flutter/material.dart';
import 'setting_screen.dart';
import '../resources/resources.dart';
import 'main_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorResources().appBar,
          title: Text(
              _selectedIndex == 0
                  ? TextResources().appTitle
                  : TextResources().settingAppTitle,
              style: Theme.of(context).textTheme.headline1),
          elevation: 8.0),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(IconsResources().homeScreenUnSelected),
                activeIcon: Icon(IconsResources().homeScreenSelected),
                label: TextResources().homeScreenLabel),
            BottomNavigationBarItem(
                icon: Icon(IconsResources().settingScreenUnSelected),
                activeIcon: Icon(IconsResources().settingScreenSelected),
                label: TextResources().settingAppTitle),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped),
    );
  }
}
