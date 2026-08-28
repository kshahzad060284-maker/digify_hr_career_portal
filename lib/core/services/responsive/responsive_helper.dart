import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import 'breakpoints.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  static Size screenUtilDesignSize(BuildContext context) {
    final size = switch (context.layout) {
      ScreenLayout.mobile => const Size(375, 812),
      ScreenLayout.tabletSmall ||
      ScreenLayout.tabletMedium => const Size(768, 1024),
      ScreenLayout.tabletLarge || ScreenLayout.desktop => const Size(1440, 900),
    };

    final landscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    if (landscape && size.height > size.width) {
      return Size(size.height, size.width);
    }
    return size;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    final padding = switch (context.layout) {
      ScreenLayout.mobile => 16.0,
      ScreenLayout.tabletSmall => 20.0,
      ScreenLayout.tabletMedium => 24.0,
      ScreenLayout.tabletLarge => 28.0,
      ScreenLayout.desktop => 32.0,
    };
    return EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5);
  }

  static double maxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return switch (context.layout) {
      ScreenLayout.mobile => width,
      ScreenLayout.tabletSmall => 1024,
      ScreenLayout.tabletMedium => 1180,
      ScreenLayout.tabletLarge => 1280,
      ScreenLayout.desktop => 1440,
    };
  }

  static double authMaxCardWidth(BuildContext context) {
    return switch (context.layout) {
      ScreenLayout.mobile => double.infinity,
      ScreenLayout.tabletSmall => 680,
      ScreenLayout.tabletMedium => 760,
      ScreenLayout.tabletLarge => 820,
      ScreenLayout.desktop => 880,
    };
  }

  static double registerMaxContentWidth(BuildContext context) {
    return switch (AppBreakpoints.fromContext(context)) {
      ScreenLayout.mobile => double.infinity,
      ScreenLayout.tabletSmall => 840,
      ScreenLayout.tabletMedium => 1000,
      ScreenLayout.tabletLarge => 1140,
      ScreenLayout.desktop => 1280,
    };
  }

  static bool registerUsesSidebarStepper(BuildContext context) {
    final layout = AppBreakpoints.fromContext(context);
    return layout.index >= ScreenLayout.tabletMedium.index;
  }

  static double registerStepsPanelWidth(BuildContext context) {
    return switch (AppBreakpoints.fromContext(context)) {
      ScreenLayout.mobile => 0,
      ScreenLayout.tabletSmall => 0,
      ScreenLayout.tabletMedium => 260,
      ScreenLayout.tabletLarge => 272,
      ScreenLayout.desktop => 280,
    };
  }

  static double registerCompactStepsMaxWidth(BuildContext context) {
    return switch (AppBreakpoints.fromContext(context)) {
      ScreenLayout.mobile => 360,
      ScreenLayout.tabletSmall => 420,
      ScreenLayout.tabletMedium => 480,
      ScreenLayout.tabletLarge => 520,
      ScreenLayout.desktop => 560,
    };
  }

  static EdgeInsetsDirectional registerContentPadding(BuildContext context) {
    final padding = pagePadding(context);
    return EdgeInsetsDirectional.only(
      top: padding.top,
      bottom: padding.bottom * 2,
    );
  }

  static double registerFormPadding(BuildContext context) {
    return switch (AppBreakpoints.fromContext(context)) {
      ScreenLayout.mobile => 20,
      ScreenLayout.tabletSmall => 24,
      ScreenLayout.tabletMedium => 28,
      ScreenLayout.tabletLarge => 28,
      ScreenLayout.desktop => 32,
    };
  }

  static double registerSectionGap(BuildContext context) {
    return switch (AppBreakpoints.fromContext(context)) {
      ScreenLayout.mobile => 24,
      ScreenLayout.tabletSmall => 28,
      ScreenLayout.tabletMedium => 32,
      ScreenLayout.tabletLarge => 36,
      ScreenLayout.desktop => 36,
    };
  }

  static double registerSidebarGap(BuildContext context) {
    return switch (AppBreakpoints.fromContext(context)) {
      ScreenLayout.mobile => 0,
      ScreenLayout.tabletSmall => 0,
      ScreenLayout.tabletMedium => 28,
      ScreenLayout.tabletLarge => 32,
      ScreenLayout.desktop => 36,
    };
  }
}
