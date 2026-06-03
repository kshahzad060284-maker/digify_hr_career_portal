import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
                            _JobMetaItem(
                              iconPath: Assets.icons.dashboard.department.path,
                              label: job.department,
                              color: metaColor,
                            ),
                            _JobMetaItem(
                              iconPath: Assets.icons.dashboard.locationPin.path,
                              label: job.location,
                              color: metaColor,
                            ),
                            _JobMetaItem(
                              iconPath: Assets.icons.dashboard.clock.path,
                              label: job.employmentType,
                              color: metaColor,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobMetaItem extends StatelessWidget {
  const _JobMetaItem({
    required this.iconPath,
    required this.label,
    required this.color,
  });

  final String iconPath;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAsset(assetPath: iconPath, width: 16.w, height: 16.w, color: color),
        Gap(4.w),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}
