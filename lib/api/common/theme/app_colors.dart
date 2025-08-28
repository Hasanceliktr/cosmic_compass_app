import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0C0D2C);
  static const Color primary = Color(0xFF8B5AEE);
  static const Color secondary = Color(0xFF6A3AEE);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8B8D2);
  static const Color cardBackground = Color(0xFF1F1F47);

  static const Color accent = Color(0xFFF7CB45);

  static const Gradient primaryGradient = LinearGradient(
    colors: [secondary, primary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}