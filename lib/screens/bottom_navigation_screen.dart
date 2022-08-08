import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'category_screen.dart';
import 'favourite_screen.dart';
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
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  void dispose() {
    _scrollController;
    super.dispose();
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
                : _selectedIndex == 1
                    ? TextResources().categoryAppTitle
                    : _selectedIndex == 2
                        ? TextResources().favoriteAppTitle
                        : TextResources().settingAppTitle,
            style: Theme.of(context).textTheme.headline1),
        elevation: 6.0,
        actions: (_selectedIndex == 3)
            ? []
            : [
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                SearchScreen(screen: _selectedIndex))),
                    // showSearch(
                    // context: context,
                    // delegate: CustomSearchDelegate(
                    //     _scrollController, _selectedIndex)),
                    icon: Icon(IconsResources().search,
                        size: 35, color: ColorResources().search))
              ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(IconsResources().homeScreenUnSelected),
                activeIcon: Icon(IconsResources().homeScreenSelected),
                label: TextResources().homeScreenLabel),
            BottomNavigationBarItem(
                icon: Icon(IconsResources().categoryScreenUnSelected),
                activeIcon: Icon(IconsResources().categoryScreenSelected),
                label: TextResources().categoryScreenLabel),
            BottomNavigationBarItem(
                icon: Icon(IconsResources().favouriteScreenUnSelected),
                activeIcon: Icon(IconsResources().favouriteScreenSelected),
                label: TextResources().favouriteScreenLabel),
            BottomNavigationBarItem(
                icon: Icon(IconsResources().settingScreenUnSelected),
                activeIcon: Icon(IconsResources().settingScreenSelected),
                label: TextResources().settingAppTitle),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: (_selectedIndex == 2)
              ? ColorResources().selectedFavoriteItemInNavigationBar
              : ColorResources().selectedItemInNavigationBar,
          onTap: _onItemTapped),
    );
  }
}
