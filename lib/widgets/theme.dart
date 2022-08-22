import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../utils/store_data.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> theme() async {
    PreferenceServices preferenceServices = PreferenceServices();
    bool value = await preferenceServices.getDarkToggle();
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    PreferenceServices preferenceServices = PreferenceServices();
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    preferenceServices.setDarkToggle(isOn);
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    fontFamily: TextResources().fontFamily,
    scaffoldBackgroundColor: Colors.grey.shade700,
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
