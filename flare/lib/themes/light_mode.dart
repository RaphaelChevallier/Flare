import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.grey[300]!,
        primary: Colors.orange,
        secondary: Colors.orangeAccent,
        tertiary: Colors.orange[200]!));

CupertinoThemeData lightModeCupertino = CupertinoThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[300]!,
    primaryColor: Colors.orange,
    primaryContrastingColor: Colors.orangeAccent);
