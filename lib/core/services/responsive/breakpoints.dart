import 'package:flutter/material.dart';

enum ScreenLayout {
  mobile,
  tabletSmall,
  tabletMedium,
  tabletLarge,
  desktop;

  bool get isMobile => this == ScreenLayout.mobile;
  bool get isTablet =>
      index >= ScreenLayout.tabletSmall.index &&
      index <= ScreenLayout.tabletLarge.index;
  bool get isDesktop => this == ScreenLayout.desktop;
}

abstract final class AppBreakpoints {
  static const double mobile = 768;
  static const double tabletSmall = 1024;
  static const double tabletMedium = 1200;
  static const double tabletLarge = 1300;

  static ScreenLayout fromWidth(double width) {
    if (width < mobile) return ScreenLayout.mobile;
    if (width < tabletSmall) return ScreenLayout.tabletSmall;
    if (width < tabletMedium) return ScreenLayout.tabletMedium;
    if (width < tabletLarge) return ScreenLayout.tabletLarge;
    return ScreenLayout.desktop;
  }

  static ScreenLayout fromContext(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);
}
