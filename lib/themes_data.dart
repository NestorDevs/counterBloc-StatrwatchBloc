import 'package:flutter/material.dart' hide Theme;
import 'models/theme.dart';

final Map<Theme, ThemeData> themesData = {
  Theme.light: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      accentColor: Colors.grey[700],
      textTheme: TextTheme(body1: TextStyle(color: Colors.grey[700]))),
  Theme.dark: ThemeData(
    brightness: Brightness.dark,
  )
};
