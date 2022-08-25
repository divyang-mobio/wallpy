import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import 'weather_screen.dart';
import '../controllers/auth_bloc/auth_bloc_bloc.dart';
import '../models/navigation_model.dart';
import '../resources/resources.dart';
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

  void _onItemTapped(int index) =>
      BlocProvider.of<BottomNavigationBloc>(context)
          .add(OnChangeBar(index: index));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          if (state is BottomNavigationInitial) {
            return const Scaffold(body: CircularProgressIndicator.adaptive());
          }
          else if (state is BottomNavigationLoaded) {
            return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: (state.index == 4)
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
                      : (state.index == 1 || state.index == 3)
                      ? []
                      : [
                    IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(
                                context, TextResources().searchScreenRoute,
                                arguments: SearchScreenArgument(
                                    selectedScreen: state.index)),
                        icon: Icon(IconsResources().search))
                  ],
                  title: Text(_widgettitle[state.index])),
              body: _widgetOptions.elementAt(state.index),
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
                  currentIndex: state.index,
                  selectedItemColor: (state.index == 2)
                      ? ColorResources().selectedFavoriteItemInNavigationBar
                      : BlocProvider
                      .of<DarkModeBloc>(context)
                      .isDark
                      ? ColorResources().selectedItemInNavigationBarDark
                      : ColorResources().selectedItemInNavigationBar,
                  onTap: _onItemTapped),
            );
          } else {
            return Scaffold(body: Text(TextResources().noData),);
          }
        });
  }
}
