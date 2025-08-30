import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade900
    ),
    scaffoldBackgroundColor: Colors.grey.shade300
  );

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        primary: Colors.grey.shade500,
        secondary: Color.fromARGB(255, 39, 39, 39),
        tertiary: Color.fromARGB(255, 25, 25, 25),
        inversePrimary: Colors.grey.shade300
    ),
    scaffoldBackgroundColor: Colors.grey.shade900
);
