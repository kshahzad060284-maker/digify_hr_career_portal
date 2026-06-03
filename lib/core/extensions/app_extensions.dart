import 'package:flutter/material.dart';

import '../services/responsive/breakpoints.dart';
import '../theme/app_colors.dart';

extension AppBuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDark => theme.brightness == Brightness.dark;

  Color get themeTextPrimary =>
      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
  Color get themeTextSecondary =>
      isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
  Color get themeCardBackground =>
      isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground;
  Color get themeCardBorder =>
      isDark ? AppColors.cardBorderDark : AppColors.cardBorder;
  Color get themeTextMuted =>
      isDark ? AppColors.textMutedDark : AppColors.textMuted;

  ScreenLayout get layout => AppBreakpoints.fromContext(this);

  T responsiveFine<T>({
    required T mobile,
    required T tabletSmall,
    required T tabletMedium,
    required T tabletLarge,
    required T desktop,
  }) {
    return switch (layout) {
      ScreenLayout.mobile => mobile,
      ScreenLayout.tabletSmall => tabletSmall,
      ScreenLayout.tabletMedium => tabletMedium,
      ScreenLayout.tabletLarge => tabletLarge,
      ScreenLayout.desktop => desktop,
    };
  }

  bool get isMobileLayout => layout.isMobile;
  bool get isTabletLayout => layout.isTablet;
  bool get isDesktopLayout => layout.isDesktop;
}
