import 'package:flutter/material.dart';
import 'package:cosmic_compass_app/common/theme/app_colors.dart';
import 'package:cosmic_compass_app/common/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,

      // textTheme ve inputDecorationTheme, ThemeData'nın parametreleridir.
      // Her birinden sonra virgül gelmelidir.

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.heading1,
        displayMedium: AppTextStyles.heading2,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
      ), // <-- BU VİRGÜL ÖNEMLİ

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // Hiç kenarlık olmasın
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary.withOpacity(0.5)),
      ), // <-- BU VİRGÜL DE İYİ BİR ALIŞKANLIKTIR

      // Gelecekte buraya AppBarTheme, ButtonTheme vb. ekleyebiliriz.

    ); // <-- ThemeData constructor'ının asıl kapanış parantezi burası.
  }
}