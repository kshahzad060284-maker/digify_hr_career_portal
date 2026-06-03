import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_filter_bar.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class JobListingContent extends ConsumerWidget {
  const JobListingContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final jobs = ref.watch(dashboardFilteredJobsProvider);
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final isDark = context.isDark;
    final sectionBg = isDark
        ? AppColors.backgroundDark
        : AppColors.sidebarSearchBg;

    return ColoredBox(
      color: sectionBg,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.fromSTEB(
          pagePadding.left,
          48.h,
          pagePadding.right,
          48.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24.h,
          children: [
            const DashboardFilterBar(),
            Text(
              l10n.dashboardPositionsAvailable(jobs.length),
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 16.sp,
              ),
            ),
            if (jobs.isEmpty)
              Text(
                l10n.dashboardNoJobsFound,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.themeTextSecondary,
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobs.length,
                separatorBuilder: (_, _) => Gap(16.h),
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return DashboardJobCard(
                    job: job,
                    onTap: () => context.goNamed(
                      AppRouteNames.jobDetails,
                      pathParameters: {'id': job.id},
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
