import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_content.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobDetailBody extends StatelessWidget {
  const DashboardJobDetailBody({
    super.key,
    required this.job,
    required this.applyButtonLabel,
    this.onApplyPressed,
    this.hasApplied = false,
    this.showApplyAction = true,
  });

  final DashboardJob job;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;
  final bool showApplyAction;

  static const double _sidebarWidth = 340;

  bool _useSideBySideLayout(BuildContext context) =>
      context.layout.index >= ScreenLayout.tabletMedium.index;

  @override
  Widget build(BuildContext context) {
    if (_useSideBySideLayout(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24.w,
        children: [
          Expanded(
            child: DashboardJobDetailContent(job: job, hasApplied: hasApplied),
          ),
          SizedBox(
            width: _sidebarWidth.w,
            child: DashboardJobDetailSidebar(
              job: job,
              applyButtonLabel: applyButtonLabel,
              onApplyPressed: onApplyPressed,
              hasApplied: hasApplied,
              showApplyAction: showApplyAction,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20.h,
      children: [
        DashboardJobDetailContent(job: job, hasApplied: hasApplied),
        DashboardJobDetailSidebar(
          job: job,
          applyButtonLabel: applyButtonLabel,
          onApplyPressed: onApplyPressed,
          hasApplied: hasApplied,
          showApplyAction: showApplyAction,
        ),
      ],
    );
  }
}
