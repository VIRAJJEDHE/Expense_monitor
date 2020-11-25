import 'package:flutter/material.dart';

import 'icons.dart';

final appTheme = ThemeData(
  brightness: Brightness.dark,
  // darkTheme: ThemeData.dark(),
  //backgroundColor: Colors.indigo[900],
  iconTheme: IconThemeData(
    size: ICON_SIZE,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 16.0),
    bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
  ),
);
