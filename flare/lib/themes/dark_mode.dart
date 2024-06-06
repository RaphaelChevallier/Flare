import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFF8A65), // Lighter Orange
    secondary: Color(0xFF64B5F6), // Lighter Blue
    surface: Color(0xFF121212), // Dark Gray
    tertiary: Color(0xFFFFCC80),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle:
        SystemUiOverlayStyle.light, // Ensures light icons on dark background
  ),
);

CupertinoThemeData darkModeCupertino = const CupertinoThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF121212), // Dark Gray
  primaryColor: Color(0xFFFF8A65), // Lighter Orange
  primaryContrastingColor: Color(0xFF64B5F6),
);
