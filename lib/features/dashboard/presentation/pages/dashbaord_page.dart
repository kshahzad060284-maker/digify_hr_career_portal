import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layouts/dashboard_desktop_layout.dart';
import '../layouts/dashboard_mobile_layout.dart';
import '../layouts/dashboard_tablet_layout.dart';

class DashboardWebLayout extends ConsumerWidget {
  const DashboardWebLayout({
    super.key,
    required this.child,
    this.showOffersNavButton = true,
    this.showApplicationsNavButton = true,
  });

  final Widget child;
  final bool showOffersNavButton;
  final bool showApplicationsNavButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (context.layout) {
      ScreenLayout.mobile => DashboardMobileLayout(
        showOffersNavButton: showOffersNavButton,
        showApplicationsNavButton: showApplicationsNavButton,
        child: child,
      ),
      ScreenLayout.desktop => DashboardDesktopLayout(
        showOffersNavButton: showOffersNavButton,
        showApplicationsNavButton: showApplicationsNavButton,
        child: child,
      ),
      _ => DashboardTabletLayout(
        showOffersNavButton: showOffersNavButton,
        showApplicationsNavButton: showApplicationsNavButton,
        child: child,
      ),
    };
  }
}
