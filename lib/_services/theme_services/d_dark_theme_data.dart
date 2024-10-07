import 'package:flutter/material.dart';
import 'm_theme_model.dart';

class DarkThemeData {
  static ThemeModel theme = ThemeModel(
      primary: const Color(
          0xFFD4AF37), // Gold/Beige accent color from the logo, used prominently in dark mode
      primarySoft:
          const Color(0xFFC5A453), // Softer variant of the gold for subtlety
      primaryAccent: const Color(
          0xFF0F2943), // Deep navy blue for accent, inverted from light theme
      primaryOver:
          Colors.black, // Black for text or icons over the primary color
      background2: const Color(
          0xFF121212), // Very dark grey, almost black for background
      background1: const Color(
          0xFF1E1E1E), // Slightly lighter grey for a subtle contrast
      text1: const Color(
          0xFFF5F5F5), // Light grey for primary text to ensure readability
      text2: const Color(0xFFB0B0B0), // Medium grey for secondary text
      disableColor:
          const Color(0xFF575757), // Darker grey for disabled elements
      secondaryAccent: const Color(
          0xFF4383FE), // Vibrant blue from the light theme as a secondary accent in dark mode
      greenSuccess: const Color(
          0xFF66BB6A), // Slightly lighter green for success messages, still distinct
      redDanger:
          const Color(0xFFEF5350), // Softer red for danger or error messages
      yellowWarning: const Color(
          0xFFFDD835), // Bright yellow for warnings, stands out against dark backgrounds
      bgGradient1: const LinearGradient(
        colors: [
          Color(0xFF121212), // Very dark grey
          Color(0xFF1E1E1E), // Slightly lighter grey
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGray: const Color.fromARGB(255, 234, 234, 234),
      icon: const Color.fromARGB(255, 233, 233, 233),
      userIcon: const Color(0xff31D988),
      mgmtIcon: const Color(0xff4F95FF));
}
