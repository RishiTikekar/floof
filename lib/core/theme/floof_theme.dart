import 'package:flutter/material.dart';

class FloofTheme {
  //color
  static const Color PRIMARY_COLOR = Color(0xFFf1eeeb);
  static const Color FONT_DARK_COLOR = Color(0xFF120e0b);
  static const Color FONT_LIGHT_COLOR = Color(0XFFda943a);
  static const Color COLOR4 = Color(0xFF8f7b8c);
  static const Color COLOR5 = Color(0xFF62412e);
  static const Color COLOR6 = Color(0xFFab641f);
  static const Color COLOR7 = Color(0xFFb6702e);

  //theme
  static ThemeData mytheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: FONT_DARK_COLOR,
    primaryColor: PRIMARY_COLOR,
    scaffoldBackgroundColor: PRIMARY_COLOR,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(FONT_DARK_COLOR),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ))),
    ),
    fontFamily: 'Nunito',
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: FONT_DARK_COLOR, fontSize: 30, fontWeight: FontWeight.w700),
      bodyText2:
          TextStyle(color: COLOR4, fontSize: 18, fontWeight: FontWeight.w300),
      headline2: TextStyle(
          color: PRIMARY_COLOR, fontSize: 18, fontWeight: FontWeight.w300),
      headline1: TextStyle(
          color: PRIMARY_COLOR, fontSize: 33, fontWeight: FontWeight.w700),
    ),
  );
}
