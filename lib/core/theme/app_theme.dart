import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData light() {
    return _buildTheme(
      brightness: Brightness.light,
      seedColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTextTheme.lightTextTheme,
      surfaceTextColor: AppColors.textPrimary,
    );
  }

  static ThemeData dark() {
    return _buildTheme(
      brightness: Brightness.dark,
      seedColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: AppTextTheme.darkTextTheme,
      surfaceTextColor: AppColors.textPrimaryDark,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color seedColor,
    required Color scaffoldBackgroundColor,
    required TextTheme textTheme,
    required Color surfaceTextColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppFonts.inter,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: surfaceTextColor,
        elevation: 0,
      ),
    );
  }
}
