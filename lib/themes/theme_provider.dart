import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:antelope/themes/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  // Constructor to initialize based on device theme
  ThemeProvider() : _themeData = _getInitialTheme();

  static ThemeData _getInitialTheme() {
    // Get the current platform brightness
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? darkMode : lightMode;
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
