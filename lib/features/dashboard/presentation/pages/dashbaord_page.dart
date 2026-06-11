import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layouts/dashboard_desktop_layout.dart';
import '../layouts/dashboard_mobile_layout.dart';
import '../layouts/dashboard_tablet_layout.dart';

class DashboardWebLayout extends ConsumerStatefulWidget {
  const DashboardWebLayout({
    super.key,
    required this.child,
    this.showOffersNavButton = true,
  });

  final Widget child;
  final bool showOffersNavButton;

  @override
  ConsumerState<DashboardWebLayout> createState() => _DashboardWebLayoutState();
}

class _DashboardWebLayoutState extends ConsumerState<DashboardWebLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardJobsControllerProvider.notifier).ensureLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (context.layout) {
      ScreenLayout.mobile => DashboardMobileLayout(
        showOffersNavButton: widget.showOffersNavButton,
        child: widget.child,
      ),
      ScreenLayout.desktop => DashboardDesktopLayout(
        showOffersNavButton: widget.showOffersNavButton,
        child: widget.child,
      ),
      _ => DashboardTabletLayout(
        showOffersNavButton: widget.showOffersNavButton,
        child: widget.child,
      ),
    };
  }
}
