import 'package:flutter/material.dart';

// all my app colors live here, one place to change everything
class AppColors {
  AppColors._(); // private constructor

  // -- primary brand colors --
  static const Color primary = Color(0xFF26A69A);       // teal - main brand color
  static const Color primaryLight = Color(0xFF80CBC4);  // light teal - hover states
  static const Color accent = Color(0xFF26A69A);         // teal - buttons, highlights

  // -- background colors --
  static const Color background = Color(0xFFFFFFFF);     // white - main background
  static const Color surface = Color(0xFFF5F5F5);        // light grey - cards, surfaces
  static const Color scaffoldBg = Color(0xFFEEF7F6);     // very light teal - scaffold background

  // -- text colors --
  static const Color textPrimary = Color(0xFF212121);    // near black - main text
  static const Color textSecondary = Color(0xFF757575);  // grey - hints, subtitles
  static const Color textDark = Color(0xFFFFFFFF);       // white - text on teal backgrounds

  // -- input field colors --
  static const Color inputFill = Color(0xFFFFFFFF);      // white input background
  static const Color inputBorder = Color(0xFFE0E0E0);    // light grey inactive border
  static const Color inputFocusBorder = Color(0xFF26A69A); // teal when focused

  // -- status colors --
  static const Color success = Color(0xFF26A69A);        // teal for success
  static const Color error = Color(0xFFE53935);          // red for errors
  static const Color warning = Color(0xFFFFB830);        // amber for warnings

  // -- misc --
  static const Color divider = Color(0xFFE0E0E0);        // light grey divider lines
  static const Color disabled = Color(0xFFBDBDBD);       // grey disabled buttons
  static const Color overlay = Color(0x8026A69A);        // semi-transparent teal overlay
}