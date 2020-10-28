import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: Colors.white,
      primaryColorBrightness: Brightness.light,

      appBarTheme: appBarTheme,
      textTheme: textTheme(),
      buttonTheme: buttonThemeData(),
      bottomNavigationBarTheme: bottomNavigationBarThemeData(),

      // cardColor: Colors.red
    );
  }

  static BottomNavigationBarThemeData bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black87,
      selectedLabelStyle: TextStyle(fontSize: 0),
      unselectedIconTheme: IconThemeData(size: 20, color: Colors.black26),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  static ButtonThemeData buttonThemeData() {
    return ButtonThemeData(
      buttonColor: Colors.brown,
      padding: EdgeInsets.all(20),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      button: TextStyle(fontFamily: "krona"),
      bodyText2: TextStyle(fontFamily: "noto"),
    );
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: Colors.transparent,
      textTheme: TextTheme(
        headline6: titleTextStyle(),
      ),
    );
  }

  static TextStyle titleTextStyle() {
    return TextStyle(
      color: Colors.black45,
      fontSize: 18,
      letterSpacing: 5,
      fontFamily: "libre",
      fontWeight: FontWeight.bold,
    );
  }

  static const TextStyle discountedTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    decoration: TextDecoration.lineThrough,
  );
  static const TextStyle errorTextStyle = TextStyle(
    color: Colors.redAccent,
    fontSize: 14,
  );
}
