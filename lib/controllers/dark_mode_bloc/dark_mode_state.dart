part of 'dark_mode_bloc.dart';

abstract class DarkModeState {}

class DarkModeLoading extends DarkModeState {}

class DarkModeLoaded extends DarkModeState {
  ThemeMode themeMode;
  bool isDark;

  DarkModeLoaded({required this.themeMode, required this.isDark});
}

class DarkModeError extends DarkModeState {}
