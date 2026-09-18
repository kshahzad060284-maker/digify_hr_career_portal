import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_desktop_layout.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_mobile_layout.dart';
import 'package:flutter/material.dart';

class DashboardJobDetailLoadedView extends StatelessWidget {
  const DashboardJobDetailLoadedView({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.applyButtonLabel,
    required this.onBack,
    required this.onApplyPressed,
    required this.hasApplied,
  });

  static double _sidebarWidth(BuildContext context) =>
      switch (AppBreakpoints.fromContext(context)) {
        ScreenLayout.mobile => 0,
        ScreenLayout.tabletSmall => 220,
        ScreenLayout.tabletMedium => 250,
        ScreenLayout.tabletLarge => 290,
        ScreenLayout.desktop => 320,
      };

  final DashboardJob job;
  final String fallbackTitle;
  final String applyButtonLabel;
  final VoidCallback onBack;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    return context.isMobileLayout
        ? DashboardJobDetailMobileLayout(
            job: job,
            fallbackTitle: fallbackTitle,
            applyButtonLabel: applyButtonLabel,
            onBack: onBack,
            onApplyPressed: onApplyPressed,
            hasApplied: hasApplied,
          )
        : DashboardJobDetailDesktopLayout(
            job: job,
            fallbackTitle: fallbackTitle,
            applyButtonLabel: applyButtonLabel,
            onBack: onBack,
            onApplyPressed: onApplyPressed,
            hasApplied: hasApplied,
            sidebarWidth: _sidebarWidth(context),
          );
  }
}
