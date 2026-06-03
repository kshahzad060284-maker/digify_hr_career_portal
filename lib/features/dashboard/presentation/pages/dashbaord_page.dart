import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:flutter/material.dart';

import '../layouts/dashboard_desktop_layout.dart';
import '../layouts/dashboard_mobile_layout.dart';
import '../layouts/dashboard_tablet_layout.dart';

class DashboardWebLayout extends StatelessWidget {
  const DashboardWebLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return switch (context.layout) {
      ScreenLayout.mobile => DashboardMobileLayout(child: child),
      ScreenLayout.desktop => DashboardDesktopLayout(child: child),
      _ => DashboardTabletLayout(child: child),
    };
  }
}
