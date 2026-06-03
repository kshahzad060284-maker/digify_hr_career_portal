import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_detail_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_body.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DashboardJobDetailPage extends ConsumerWidget {
  const DashboardJobDetailPage({super.key, required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final job = ref.watch(dashboardJobByIdProvider(jobId));
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final isDark = context.isDark;
    final sectionBg = isDark
        ? AppColors.backgroundDark
        : AppColors.sidebarSearchBg;

    return ColoredBox(
      color: sectionBg,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardJobDetailHeader(
              job: job,
              fallbackTitle: l10n.dashboardJobDetailTitle(jobId),
              onBack: () => context.pop(),
              onSignInToApply: () {},
            ),
            if (job != null)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  pagePadding.left,
                  32.h,
                  pagePadding.right,
                  48.h,
                ),
                child: DashboardJobDetailBody(job: job, onSignInToApply: () {}),
              )
            else
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  pagePadding.left,
                  32.h,
                  pagePadding.right,
                  48.h,
                ),
                child: Text(
                  l10n.dashboardJobDetailNotFound,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.themeTextSecondary,
                    fontSize: 16.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
