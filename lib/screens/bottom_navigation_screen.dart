import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/auth_bloc/auth_bloc_bloc.dart';
import 'package:wallpy/resources/resources.dart';
import 'search_screen.dart';
import 'category_screen.dart';
import 'favourite_screen.dart';
import 'setting_screen.dart';
import '../resources/resources.dart';
import 'main_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  //final User currentUser;
  // ignore: use_key_in_widget_constructors
  const BottomNavigationBarScreen();

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
          actions: (_selectedIndex == 3)
              ? [
                  IconButton(
                      onPressed: () {
                        context.read<AuthBlocBloc>().add(SignOutRequested());
                      },
                      icon: Icon(
                        IconsResources().logout,
                        color: ColorResources().appBarTextIcon,
                      ))
                ]
              : [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  SearchScreen(screen: _selectedIndex))),
                      icon: Icon(IconsResources().search,
                          size: 35, color: ColorResources().search))
                ],
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
          elevation: 6.0),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            for (var i in bottomData)
              BottomNavigationBarItem(
                  icon: Icon(i.icon),
                  activeIcon: Icon(i.actionIcon),
                  label: i.label),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: (_selectedIndex == 2)
              ? ColorResources().selectedFavoriteItemInNavigationBar
              : ColorResources().selectedItemInNavigationBar,
          onTap: _onItemTapped),
    );
  }
}
