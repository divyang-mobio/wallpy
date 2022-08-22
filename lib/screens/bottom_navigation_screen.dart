import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpy/screens/weather_screen.dart';
import 'package:wallpy/widgets/theme.dart';
import '../controllers/auth_bloc/auth_bloc_bloc.dart';
import '../models/navigation_model.dart';
import '../resources/resources.dart';
import '../widgets/appicon_text.dart';
import 'category_screen.dart';
import 'favourite_screen.dart';
import 'news_screen.dart';
import 'setting_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BottomNavigationBarScreen();

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // MyHomePage(),
    CategoryScreen(),
    WeatherScreen(),
    FavouriteScreen(),
    NewsScreen(),
    SettingScreen()
  ];
  static final List<String> _widgettitle = <String>[
    TextResources().appTitle,
    // TextResources().categoryAppTitle,
    TextResources().weatherTitle,
    TextResources().favoriteAppTitle,
    TextResources().newsAppTitle,
    TextResources().settingAppTitle,
  ];

  void _onItemTapped(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? ColorResources().appBarTextIconDark
                  : ColorResources().appBarTextIcon),
          actions: (_selectedIndex == 4)
              ? [
                  IconButton(
                      onPressed: () {
                        context.read<AuthBlocBloc>().add(SignOutRequested());
                        Navigator.pushReplacementNamed(
                          context,
                          TextResources().welcomeScreenRoute,
                        );
                      },
                      icon: Icon(IconsResources().logOut))
                ]
              : (_selectedIndex == 1 || _selectedIndex == 3)
                  ? []
                  : [
                      IconButton(
                          onPressed: () => Navigator.pushNamed(
                              context, TextResources().searchScreenRoute,
                              arguments: SearchScreenArgument(
                                  selectedScreen: _selectedIndex)),
                          icon: Icon(IconsResources().search))
                    ],
          backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
              ? ColorResources().appBarDark
              : ColorResources().appBar,
          title: Text(_widgettitle[_selectedIndex],
              style: appBarTextStyle(context)),
          elevation: 0.0),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
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
              : Provider.of<ThemeProvider>(context).isDarkMode
                  ? ColorResources().selectedItemInNavigationBarDark
                  : ColorResources().selectedItemInNavigationBar,
          onTap: _onItemTapped),
    );
  }
}
