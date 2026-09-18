import 'package:career_portal/core/extensions/app_extensions.dart';
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

  static const double _sidebarWidth = 320;

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
            sidebarWidth: _sidebarWidth,
          );
  }
}
