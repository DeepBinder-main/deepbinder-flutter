import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 21, 37, 117),
    fontFamily: GoogleFonts.nunito().fontFamily,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
        bodyText1: TextStyle(fontSize: 18),
        bodyText2: TextStyle(fontSize: 16),
        button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold)));
