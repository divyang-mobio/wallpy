import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/admin_visible_bloc/admin_visible_bloc.dart';
import '../controllers/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'gradiant_screen.dart';
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
    GradiantScreen(),
    WeatherScreen(),
    FavouriteScreen(),
    NewsScreen(),
    SettingScreen()
  ];
  static final List<String> _widgettitle = <String>[
    TextResources().appTitle,
    // TextResources().categoryAppTitle,
    TextResources().gradiantAppTitle,
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
      } else if (state is BottomNavigationLoaded) {
        return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: (state.index == 5)
                  ? [
                      IconButton(
                          onPressed: () {
                            context
                                .read<AuthBlocBloc>()
                                .add(SignOutRequested());
                            Navigator.pushReplacementNamed(
                                context, TextResources().welcomeScreenRoute);
                            BlocProvider.of<AdminVisibleBloc>(context)
                                .add(UnSetAdmin());
                          },
                          icon: Icon(IconsResources().logOut))
                    ]
                  : (state.index == 1 || state.index == 2 || state.index == 4)
                      ? []
                      : [
                          IconButton(
                              onPressed: () => Navigator.pushNamed(
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
              items: bottomData
                  .map((e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      activeIcon: Icon(e.actionIcon),
                      label: e.label))
                  .toList(),
              currentIndex: state.index,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              onTap: _onItemTapped),
        );
      } else {
        return Scaffold(
          body: Text(TextResources().noData),
        );
      }
    });
  }
}
