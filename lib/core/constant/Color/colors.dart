import 'package:flutter/material.dart';

class AppColors {
  // Background color for all pages
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFD02E76),
      Color(0xFF1B1919),
      Color(0xFF1B1919),
      Color(0xFF1B1919),
      Color(0xFF1B1919),
      Color(0xFFD02E76),
    ],
  );
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topRight,
    colors: [
      Color(0xFFD02E76),
      Color(0xFF1B1919),
      Color(0xFF1B1919),
    ],
  );
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF9C3FE4), // purple
      Color(0xFFC65647), // reddish-orange
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Right-to-left (reverse)
  static const LinearGradient buttonGradientRev = LinearGradient(
    colors: [
      Color(0xFFC65647),
      Color(0xFF9C3FE4),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    transform: GradientRotation(3.14159), // rotate to reverse direction
  );
}
