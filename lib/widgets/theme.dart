import 'package:flutter/material.dart';
import '../resources/resources.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    fontFamily: TextResources().fontFamily,
    scaffoldBackgroundColor: Colors.grey.shade800,
    colorScheme: const ColorScheme.dark(),
    primarySwatch: Colors.grey,
    textTheme: const TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
  );
  static final lightTheme = ThemeData(
    fontFamily: TextResources().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.grey,
    colorScheme: const ColorScheme.light(),
    textTheme: const TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
  );
}
