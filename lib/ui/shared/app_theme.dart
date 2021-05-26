import 'package:flutter/material.dart';

import 'package:booksea/core/extension/num_extension.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColorBrightness: Brightness.light,
    backgroundColor: Color(0xffe9e9e9),
    primaryColor: Colors.white,
    accentColor: Colors.blue,
    splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
    highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
    appBarTheme: _appbarTheme(),
    shadowColor: Colors.grey[300],
    indicatorColor: Colors.black,
    bottomAppBarTheme: BottomAppBarTheme(elevation: 5),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color:Colors.black,fontSize: 96.px,fontWeight: FontWeight.w300),
      headline2: TextStyle(color:Colors.black,fontSize: 60.px.px,fontWeight: FontWeight.w300),
      headline3: TextStyle(color:Colors.black,fontSize: 48.px),
      headline4: TextStyle(color:Colors.black,fontSize: 34.px),
      headline5: TextStyle(color:Colors.black,fontSize: 24.px),
      headline6: TextStyle(color:Colors.black,fontSize: 18.px, fontWeight: FontWeight.w500),
      subtitle1: TextStyle(color:Colors.black,fontSize: 14.px, letterSpacing: 0.15, fontWeight: FontWeight.w400),
      subtitle2: TextStyle(color:Colors.black,fontSize: 12.px, letterSpacing: 0.15, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(color:Colors.black,fontSize: 14.px, letterSpacing: 0.5, fontWeight: FontWeight.w400),
      bodyText2: TextStyle(color:Colors.black,fontSize: 12.px, letterSpacing: 0.25, fontWeight: FontWeight.w400),
    )
  );

  static final darkTheme = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    primaryColor: Colors.black87,
    accentColor: Colors.blue,
    splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
    highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
    brightness: Brightness.dark,
    appBarTheme: _appbarTheme(isDarkMode: true),
    bottomAppBarColor: Color(0xff1A1A1D),
    indicatorColor: Color(0xffB3B2B3),
    iconTheme: IconThemeData(
      color: Color(0xffB3B2B3),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0.px, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 18.0.px, fontWeight: FontWeight.bold, color: Color(0xffB3B2B3),),
      subtitle1: TextStyle(fontSize: 16.0.px, fontWeight: FontWeight.bold, color: Color(0xffB3B2B3),),
      subtitle2: TextStyle(fontSize: 14.0.px, color: Color(0xffB3B2B3),),
      bodyText1: TextStyle(color: Color(0xffB3B2B3), fontSize: 16.px, fontFamily: "WeChatSans",),
      bodyText2: TextStyle(color: Color(0xffB3B2B3), fontSize: 14.px, fontFamily: "WeChatSans",),
    ),
  );
}

AppBarTheme _appbarTheme({bool isDarkMode = false}) {
  return AppBarTheme(
    color: isDarkMode ? Color(0xff1A1A1D) : Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline6: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 16.px),
    ),
    iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
    actionsIconTheme:
    IconThemeData(color: isDarkMode ? Color(0xffB3B2B3) : Colors.black),
  );
}
