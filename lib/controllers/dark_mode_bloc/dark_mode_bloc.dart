import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../utils/store_data.dart';

part 'dark_mode_event.dart';

part 'dark_mode_state.dart';

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  PreferenceServices pref;
  ThemeMode themeMode = ThemeMode.light;
  DarkModeBloc(this.pref) : super(DarkModeLoading()) {
    on<OnChangeMode>((event, emit) {
      pref.setDarkToggle(event.isDark);
      themeMode = event.isDark ? ThemeMode.dark : ThemeMode.light;
      emit(DarkModeLoaded(themeMode: themeMode, isDark: event.isDark));
    });
    on<Check>((event, emit) async {
      bool value = await pref.getDarkToggle();
      themeMode = value ? ThemeMode.dark : ThemeMode.light;
      emit(DarkModeLoaded(themeMode: themeMode, isDark: value));
    });
  }

  get isDark => themeMode == ThemeMode.dark;
}
