import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:flutter/material.dart';

import 'dashboard_desktop_layout.dart';
import 'dashboard_mobile_layout.dart';
import 'dashboard_tablet_layout.dart';

class DashboardWebLayout extends StatelessWidget {
  const DashboardWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.layout) {
      ScreenLayout.mobile => const DashboardMobileLayout(),
      ScreenLayout.desktop => const DashboardDesktopLayout(),
      _ => const DashboardTabletLayout(),
    };
  }
}
