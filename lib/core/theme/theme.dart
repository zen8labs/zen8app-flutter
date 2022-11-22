import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    fontFamily: "Silkscreen",
    primaryColor: Color.fromARGB(255, 255, 0, 0),
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
    ),
  );
}
