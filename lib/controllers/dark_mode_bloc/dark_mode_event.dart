part of 'dark_mode_bloc.dart';

abstract class DarkModeEvent {}

class OnChangeMode extends DarkModeEvent {
  bool isDark;

  OnChangeMode({required this.isDark});
}

class Check extends DarkModeEvent {}
