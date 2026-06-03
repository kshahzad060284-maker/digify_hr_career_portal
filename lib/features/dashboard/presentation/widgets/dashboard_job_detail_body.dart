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
    this.onSignInToApply,
  });

  final DashboardJob job;
  final VoidCallback? onSignInToApply;

  static const double _sidebarWidth = 320;

  bool _useSideBySideLayout(BuildContext context) =>
      context.layout.index >= ScreenLayout.tabletMedium.index;

  @override
  Widget build(BuildContext context) {
    if (_useSideBySideLayout(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24.w,
        children: [
          Expanded(child: DashboardJobDetailContent(job: job)),
          SizedBox(
            width: _sidebarWidth.w,
            child: DashboardJobDetailSidebar(
              job: job,
              onSignInToApply: onSignInToApply,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24.h,
      children: [
        DashboardJobDetailContent(job: job),
        DashboardJobDetailSidebar(job: job, onSignInToApply: onSignInToApply),
      ],
    );
  }
}
