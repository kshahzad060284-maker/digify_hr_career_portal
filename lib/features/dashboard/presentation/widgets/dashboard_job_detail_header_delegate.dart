import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  DashboardJobDetailHeaderDelegate({
    required this.job,
    required this.fallbackTitle,
    required this.onBack,
    required this.applyButtonLabel,
    required this.onApplyPressed,
    required this.hasApplied,
  });

  final DashboardJob job;
  final String fallbackTitle;
  final VoidCallback onBack;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;

  @override
  double get minExtent => 64.h;

  @override
  double get maxExtent => 158.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final collapseProgress = (shrinkOffset / (maxExtent - minExtent)).clamp(
      0.0,
      1.0,
    );

    return SizedBox.expand(
      child: DashboardJobDetailHeader(
        job: job,
        fallbackTitle: fallbackTitle,
        onBack: onBack,
        applyButtonLabel: applyButtonLabel,
        onApplyPressed: onApplyPressed,
        hasApplied: hasApplied,
        showApplyAction: true,
        collapseProgress: collapseProgress,
      ),
    );
  }

  @override
  bool shouldRebuild(DashboardJobDetailHeaderDelegate oldDelegate) =>
      job != oldDelegate.job ||
      fallbackTitle != oldDelegate.fallbackTitle ||
      applyButtonLabel != oldDelegate.applyButtonLabel ||
      hasApplied != oldDelegate.hasApplied ||
      onApplyPressed != oldDelegate.onApplyPressed;
}
