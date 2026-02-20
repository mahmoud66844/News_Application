import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isLightMode => themeMode == ThemeMode.light;

  changeThemeMode(ThemeMode newThemeMode) {
    themeMode = newThemeMode;
    notifyListeners();

    ///Replacment of setState with widgets
  }
}
