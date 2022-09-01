import 'package:flutter/material.dart';
import '../resources/resources.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ColorResources().selectedItemInNavigationBarDark),
    fontFamily: TextResources().fontFamily,
    scaffoldBackgroundColor: ColorResources().scaffoldBackgroundColorDark,
    colorScheme: const ColorScheme.dark(),
    primarySwatch: ColorResources().primarySwatchDark,
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontSize: 20,
            color: ColorResources().appBarTextIconDark,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorResources().appBarTextIconDark),
        backgroundColor: ColorResources().appBarDark,
        elevation: 0.0),
    textTheme: const TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
  );
  static final lightTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorResources().selectedItemInNavigationBar,
    ),
    fontFamily: TextResources().fontFamily,
    scaffoldBackgroundColor: ColorResources().scaffoldBackgroundColor,
    primarySwatch: ColorResources().primarySwatch,
    colorScheme: const ColorScheme.light(),
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontSize: 20,
            color: ColorResources().appBarTextIcon,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorResources().appBarTextIcon),
        backgroundColor: ColorResources().appBar,
        elevation: 0.0),
    textTheme: const TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
  );
}
