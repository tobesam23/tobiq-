import 'package:flutter/material.dart';

// all my app colors live here, one place to change everything
class AppColors {
  AppColors._(); // private constructor, no one should instantiate this

  // -- primary brand colors --
  static const Color primary = Color(0xFF2D1B69);       // deep purple - main background & brand
  static const Color primaryLight = Color(0xFF3D2B7A);  // slightly lighter purple - cards, surfaces
  static const Color accent = Color(0xFF00E5CC);         // mint - buttons, highlights, active states

  // -- background colors --
  static const Color background = Color(0xFF2D1B69);     // main screen background
  static const Color surface = Color(0xFF3D2B7A);        // cards, bottom sheets, dialogs
  static const Color scaffoldBg = Color(0xFF250F5A);     // darkest purple - scaffold background

  // -- text colors --
  static const Color textPrimary = Color(0xFFFFFFFF);    // white - main text on dark bg
  static const Color textSecondary = Color(0xFFB0A8D0);  // muted purple-white - hints, subtitles
  static const Color textDark = Color(0xFF2D1B69);       // for text on light/mint backgrounds

  // -- input field colors --
  static const Color inputFill = Color(0xFF3D2B7A);      // input background
  static const Color inputBorder = Color(0xFF5A4A8A);    // inactive border
  static const Color inputFocusBorder = Color(0xFF00E5CC); // mint when focused

  // -- status colors --
  static const Color success = Color(0xFF00E5CC);        // reusing mint for success
  static const Color error = Color(0xFFFF4D6A);          // red-pink for errors
  static const Color warning = Color(0xFFFFB830);        // amber for warnings

  // -- misc --
  static const Color divider = Color(0xFF4A3A7A);        // subtle divider lines
  static const Color disabled = Color(0xFF5A4A8A);       // disabled buttons/inputs
  static const Color overlay = Color(0x802D1B69);        // semi-transparent overlay
}