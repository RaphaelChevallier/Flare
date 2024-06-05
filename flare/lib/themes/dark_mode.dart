import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Colors.grey[800]!,
        primary: Colors.deepOrange,
        secondary: Colors.deepOrangeAccent));

CupertinoThemeData darkModeCupertino = CupertinoThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[800]!,
    primaryColor: Colors.deepOrange,
    primaryContrastingColor: Colors.deepOrangeAccent);
