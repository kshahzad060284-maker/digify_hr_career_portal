import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_body.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_header.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_mobile_apply_bar.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobDetailMobileLayout extends StatelessWidget {
  const DashboardJobDetailMobileLayout({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.applyButtonLabel,
    required this.onBack,
    required this.onApplyPressed,
    required this.hasApplied,
  });

  final DashboardJob job;
  final String fallbackTitle;
  final String applyButtonLabel;
  final VoidCallback onBack;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = EdgeInsets.symmetric(horizontal: 16.w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            primary: true,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: DashboardJobDetailHeader(
                  job: job,
                  fallbackTitle: fallbackTitle,
                  onBack: onBack,
                  applyButtonLabel: applyButtonLabel,
                  onApplyPressed: onApplyPressed,
                  hasApplied: hasApplied,
                  showApplyAction: false,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: horizontalPadding.copyWith(top: 20.h, bottom: 4.h),
                  child: DashboardJobDetailSidebar(
                    job: job,
                    postingGuid: job.id,
                    applyButtonLabel: applyButtonLabel,
                    onApplyPressed: onApplyPressed,
                    hasApplied: hasApplied,
                    showApplyAction: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: horizontalPadding.copyWith(top: 20.h, bottom: 40.h),
                  child: DashboardJobDetailBody(
                    job: job,
                    hasApplied: hasApplied,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 88.h)),
            ],
          ),
        ),
        DashboardJobDetailMobileApplyBar(
          applyButtonLabel: applyButtonLabel,
          onApplyPressed: onApplyPressed,
          hasApplied: hasApplied,
        ),
      ],
    );
  }
}
