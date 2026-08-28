import 'package:flutter/material.dart';

import '../services/responsive/breakpoints.dart';
import '../services/responsive/responsive_helper.dart';
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

  EdgeInsets get pagePadding => ResponsiveHelper.pagePadding(this);

  double get maxContentWidth => ResponsiveHelper.maxContentWidth(this);

  double get authMaxCardWidth => ResponsiveHelper.authMaxCardWidth(this);

  double get registerMaxContentWidth =>
      ResponsiveHelper.registerMaxContentWidth(this);

  bool get registerUsesSidebarStepper =>
      ResponsiveHelper.registerUsesSidebarStepper(this);

  double get registerStepsPanelWidth =>
      ResponsiveHelper.registerStepsPanelWidth(this);

  double get registerCompactStepsMaxWidth =>
      ResponsiveHelper.registerCompactStepsMaxWidth(this);

  EdgeInsetsDirectional get registerContentPadding =>
      ResponsiveHelper.registerContentPadding(this);

  double get registerFormPadding => ResponsiveHelper.registerFormPadding(this);

  double get registerSectionGap => ResponsiveHelper.registerSectionGap(this);

  double get registerSidebarGap => ResponsiveHelper.registerSidebarGap(this);

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
