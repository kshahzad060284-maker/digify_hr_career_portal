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
}
