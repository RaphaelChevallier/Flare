import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFF7043), // Orange
    secondary: Color(0xFF42A5F5), // Blue
    surface: Color(0xF5F5F5F5), // White
    tertiary: Color(0xFFFFAB40),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle:
        SystemUiOverlayStyle.dark, // Ensures dark icons on light background
  ),
);

CupertinoThemeData lightModeCupertino = const CupertinoThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xF5F5F5F5), // White
  primaryColor: Color(0xFFFF7043), // Orange
  primaryContrastingColor: Color(0xFF42A5F5),
);
