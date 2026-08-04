import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_footer.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_body.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_header.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_mobile_apply_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobDetailLoadedView extends StatelessWidget {
  const DashboardJobDetailLoadedView({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.applyButtonLabel,
    required this.onBack,
    this.onApplyPressed,
    this.hasApplied = false,
  });

  final DashboardJob job;
  final String fallbackTitle;
  final String applyButtonLabel;
  final VoidCallback onBack;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    final horizontalInset = 30.w;
    final maxWidth = MediaQuery.sizeOf(context).width;
    final isMobile = context.isMobileLayout;

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
                  showApplyAction: !isMobile,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        horizontalInset,
                        isMobile ? 20.h : 28.h,
                        horizontalInset,
                        isMobile ? 24.h : 40.h,
                      ),
                      child: DashboardJobDetailBody(
                        job: job,
                        applyButtonLabel: applyButtonLabel,
                        onApplyPressed: onApplyPressed,
                        hasApplied: hasApplied,
                        showApplyAction: !isMobile,
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: DashboardFooter()),
              if (isMobile) SliverToBoxAdapter(child: SizedBox(height: 88.h)),
            ],
          ),
        ),
        if (isMobile)
          DashboardJobDetailMobileApplyBar(
            applyButtonLabel: applyButtonLabel,
            onApplyPressed: onApplyPressed,
            hasApplied: hasApplied,
          ),
      ],
    );
  }
}
