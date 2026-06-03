import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static const TextBaseline textBaseline = TextBaseline.alphabetic;
  static const double _defaultHeight = 1.2;

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    return TextStyle(
      inherit: false,
      fontFamily: AppFonts.inter,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height ?? _defaultHeight,
      letterSpacing: 0,
      textBaseline: textBaseline,
    );
  }

  static TextTheme get lightTextTheme {
    return TextTheme(
      labelSmall: _style(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      labelMedium: _style(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      labelLarge: _style(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodySmall: _style(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      bodyMedium: _style(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodyLarge: _style(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      titleSmall: _style(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      titleMedium: _style(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: _style(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: _style(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: _style(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      headlineLarge: _style(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displaySmall: _style(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displayMedium: _style(
        fontSize: 28.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
      displayLarge: _style(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      labelSmall: _style(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
      ),
      labelMedium: _style(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryDark,
      ),
      labelLarge: _style(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
      bodySmall: _style(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
      ),
      bodyMedium: _style(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
      ),
      bodyLarge: _style(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
      ),
      titleSmall: _style(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimaryDark,
      ),
      titleMedium: _style(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
      titleLarge: _style(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
      headlineSmall: _style(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
      headlineMedium: _style(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
      ),
      headlineLarge: _style(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
      ),
      displaySmall: _style(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
      ),
      displayMedium: _style(
        fontSize: 28.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimaryDark,
      ),
      displayLarge: _style(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimaryDark,
      ),
    );
  }
}
