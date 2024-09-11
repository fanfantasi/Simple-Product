import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeModel {
  final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue.shade100,
    scaffoldBackgroundColor: Colors.white,
    shadowColor: Colors.grey[200],
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Colors.grey.shade700, 
        secondary: Colors.blue.shade50,
        onPrimary: Colors.white,
        onSecondary: Colors.blue.shade100,
        primaryContainer: Colors.blue.shade200,
        secondaryContainer: Colors.grey[300]!,
        surface: Colors.grey[300]!,
        shadow: const Color.fromRGBO(0, 0, 0, 0.13),
        onBackground: Colors.grey.shade200, //loading card color
        background: Colors.grey.shade700),
    dividerColor: Colors.grey.shade400,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    primaryIconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800]),
      iconTheme: IconThemeData(color: Colors.grey[900]),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.white24,
      unselectedItemColor: Colors.blueGrey[200],
    ),
    popupMenuTheme: PopupMenuThemeData(
      textStyle: TextStyle(
        color: Colors.grey[900],
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
