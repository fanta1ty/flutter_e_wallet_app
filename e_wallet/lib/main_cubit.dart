import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(
          MainState.init(
            themeData: _lightTheme,
            isDarkMode: false,
          ),
        );

  static final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.light,
  );

  static final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
  );

  void toggleTheme(bool isDarkMode) {
    emit(MainState(
      themeData: isDarkMode ? _darkTheme : _lightTheme,
      isDarkMode: isDarkMode,
    ));
  }
}
