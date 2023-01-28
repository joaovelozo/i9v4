import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color loginButtonColor = Colors.purple;
  static Color signupButtonColor = Colors.grey.shade400;
  static Color loginPageBoxColor = Color(0xffccccff);

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        canvasColor: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        colorScheme: ColorScheme(
          primary: Colors.black,
          secondary: Colors.black87,
          surface: Colors.cyan.shade50,
          background: Colors.cyan.shade100,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.red,
          brightness: Brightness.light,
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        canvasColor: Colors.black,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.black,
        colorScheme: ColorScheme(
          primary: Colors.white,
          secondary: Colors.white,
          surface: Colors.cyan.shade50,
          background: Colors.cyan.shade100,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.red,
          brightness: Brightness.dark,
        ),
      );
}