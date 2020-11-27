import 'package:flutter/material.dart';

import 'icons.dart';

final appTheme = ThemeData(
  brightness: Brightness.dark,
  iconTheme: IconThemeData(
    size: ICON_SIZE,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 16.0, color: Colors.amber),
    bodyText2: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.amber),
    subtitle1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.lightGreenAccent),
  ),
);
