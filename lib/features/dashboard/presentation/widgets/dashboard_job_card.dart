import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/models/job_application_status.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_meta_item.dart';
import 'package:career_portal/shared/widgets/common/app_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobCard extends StatelessWidget {
  const DashboardJobCard({super.key, required this.job, this.onTap});

  final DashboardJob job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final metaColor = AppColors.textSecondary;
    final descriptionColor = AppColors.textDarkSlate;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.dashboardCard,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.dashboardCardBorder),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Text(
                          job.title,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 20.sp,
                          ),
                        ),
                        Wrap(
                          spacing: 16.w,
                          runSpacing: 8.h,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            DashboardJobMetaItem(
                              iconPath: Assets.icons.dashboard.department.path,
                              label: job.department,
                              color: metaColor,
                              iconGap: 4.w,
                            ),
                            DashboardJobMetaItem(
                              iconPath: Assets.icons.dashboard.locationPin.path,
                              label: job.location,
                              color: metaColor,
                              iconGap: 4.w,
                            ),
                            DashboardJobMetaItem(
                              iconPath: Assets.icons.dashboard.clock.path,
                              label: job.employmentType,
                              color: metaColor,
                              iconGap: 4.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 24.sp,
                    color: isDark
                        ? AppColors.textPlaceholderDark
                        : AppColors.textPlaceholder,
                  ),
                ],
              ),
              Text(
                job.description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: descriptionColor,
                  fontSize: 16.sp,
                ),
              ),
              Wrap(
                spacing: 12.w,
                runSpacing: 8.h,
                children: [
                  AppCapsule(
                    label: l10n.dashboardJobOpenings(job.openingsCount),
                    backgroundColor: isDark
                        ? AppColors.infoBg.withValues(alpha: 0.2)
                        : AppColors.infoBg,
                    textColor: AppColors.roleActionBlue,
                  ),
                  if (job.isUrgent)
                    AppCapsule(
                      label: l10n.dashboardJobUrgentHiring,
                      backgroundColor: isDark
                          ? AppColors.redBg.withValues(alpha: 0.2)
                          : AppColors.redBg,
                      textColor: AppColors.brandRed,
                    ),
                  if (job.applicationStatus != null)
                    _ApplicationStatusCapsule(
                      status: job.applicationStatus!,
                      isDark: isDark,
                      l10n: l10n,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ApplicationStatusCapsule extends StatelessWidget {
  const _ApplicationStatusCapsule({
    required this.status,
    required this.isDark,
    required this.l10n,
  });

  final JobApplicationStatus status;
  final bool isDark;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isApplied = status == JobApplicationStatus.applied;

    return AppCapsule(
      label: isApplied
          ? l10n.dashboardJobApplicationStatusApplied
          : l10n.dashboardJobApplicationStatusNotApplied,
      backgroundColor: isApplied
          ? (isDark
                ? AppColors.successBg.withValues(alpha: 0.2)
                : AppColors.successBg)
          : (isDark
                ? AppColors.warningBg.withValues(alpha: 0.2)
                : AppColors.warningBg),
      textColor: isApplied
          ? (isDark ? AppColors.successTextDark : AppColors.successText)
          : (isDark ? AppColors.warningTextDark : AppColors.warningText),
    );
  }
}
