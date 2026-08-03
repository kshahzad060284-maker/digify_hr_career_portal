import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_meta_item.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_share_link_button.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
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
    final isMobile = context.isMobileLayout;

    final cardColor = isDark
        ? AppColors.cardBackgroundDark
        : AppColors.dashboardCard;
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.dashboardCardBorder;
    final titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimary;
    final metaColor = isDark
        ? AppColors.textTertiaryDark
        : AppColors.textTertiary;
    final descriptionColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;
    final dividerColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorder;
    final radius = 10.r;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: AppColors.shadowColor.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              isMobile ? 16.w : 20.w,
              isMobile ? 16.h : 18.h,
              isMobile ? 16.w : 20.w,
              isMobile ? 16.h : 18.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        job.title,
                        style: context.textTheme.titleSmall?.copyWith(
                          color: titleColor,
                          fontSize: isMobile ? 16.sp : 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Gap(12.w),
                    DashboardJobShareLinkButton(jobId: job.id),
                  ],
                ),
                Gap(10.h),
                Wrap(
                  spacing: 14.w,
                  runSpacing: 8.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    DashboardJobMetaItem(
                      iconPath: Assets.icons.dashboard.department.path,
                      label: job.department,
                      color: metaColor,
                      iconSize: 12.w,
                      iconGap: 6.w,
                    ),
                    DashboardJobMetaItem(
                      iconPath: Assets.icons.dashboard.locationPin.path,
                      label: job.location,
                      color: metaColor,
                      iconSize: 12.w,
                      iconGap: 6.w,
                    ),
                    DashboardJobMetaItem(
                      iconPath: Assets.icons.dashboard.clock.path,
                      label: job.employmentType,
                      color: metaColor,
                      iconSize: 12.w,
                      iconGap: 6.w,
                    ),
                  ],
                ),
                if (job.description.trim().isNotEmpty) ...[
                  Gap(12.h),
                  Text(
                    job.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: descriptionColor,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
                Gap(14.h),
                AppDivider.horizontal(color: dividerColor),
                Gap(14.h),
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _JobCardTags(job: job, isDark: isDark, l10n: l10n),
                      Gap(12.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: AppButton.outline(
                          label: l10n.dashboardJobViewDetails,
                          onPressed: onTap,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _JobCardTags(
                          job: job,
                          isDark: isDark,
                          l10n: l10n,
                        ),
                      ),
                      Gap(16.w),
                      AppButton.outline(
                        label: l10n.dashboardJobViewDetails,
                        onPressed: onTap,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _JobCardTags extends StatelessWidget {
  const _JobCardTags({
    required this.job,
    required this.isDark,
    required this.l10n,
  });

  final DashboardJob job;
  final bool isDark;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppCapsule(
          label: l10n.dashboardJobOpenings(job.openingsCount),
          backgroundColor: isDark
              ? AppColors.infoBg.withValues(alpha: 0.18)
              : AppColors.infoBg,
          textColor: isDark ? AppColors.infoTextDark : AppColors.roleActionBlue,
          borderColor: isDark
              ? AppColors.infoBorder.withValues(alpha: 0.35)
              : AppColors.infoBorder,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          textStyle: context.textTheme.labelSmall?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.infoTextDark : AppColors.roleActionBlue,
          ),
        ),
        if (job.isUrgent)
          AppCapsule(
            label: l10n.dashboardJobUrgentHiring,
            backgroundColor: isDark
                ? AppColors.redBg.withValues(alpha: 0.18)
                : AppColors.redBg,
            textColor: AppColors.brandRed,
            borderColor: isDark
                ? AppColors.errorBorder.withValues(alpha: 0.35)
                : AppColors.errorBorder,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            textStyle: context.textTheme.labelSmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.brandRed,
            ),
          ),
        if (job.hasApplied) _AppliedStatusCapsule(isDark: isDark, l10n: l10n),
      ],
    );
  }
}

class _AppliedStatusCapsule extends StatelessWidget {
  const _AppliedStatusCapsule({required this.isDark, required this.l10n});

  final bool isDark;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark
        ? AppColors.successTextDark
        : AppColors.successText;

    return AppCapsule(
      label: l10n.dashboardJobApplicationStatusApplied,
      backgroundColor: isDark
          ? AppColors.successBg.withValues(alpha: 0.18)
          : AppColors.successBg,
      textColor: textColor,
      borderColor: isDark
          ? AppColors.successBorder.withValues(alpha: 0.35)
          : AppColors.successBorder,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      textStyle: context.textTheme.labelSmall?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
