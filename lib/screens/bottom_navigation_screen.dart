import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/auth_bloc/auth_bloc_bloc.dart';
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
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    FavouriteScreen(),
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
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBlocBloc>().add(SignOutRequested());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
          backgroundColor: ColorResources().appBar,
          title: Text(
              _selectedIndex == 0
                  ? TextResources().appTitle
                  : _selectedIndex == 1
                      ? TextResources().favoriteAppTitle
                      : TextResources().settingAppTitle,
              style: Theme.of(context).textTheme.headline1),
          elevation: 6.0),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(IconsResources().homeScreenUnSelected),
                activeIcon: Icon(IconsResources().homeScreenSelected),
                label: TextResources().homeScreenLabel),
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
          selectedItemColor: (_selectedIndex == 1)
              ? ColorResources().selectedFavoriteItemInNavigationBar
              : ColorResources().selectedItemInNavigationBar,
          onTap: _onItemTapped),
    );
  }
}
