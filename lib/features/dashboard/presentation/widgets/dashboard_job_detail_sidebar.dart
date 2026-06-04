import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailSidebar extends StatelessWidget {
  const DashboardJobDetailSidebar({
    super.key,
    required this.job,
    required this.applyButtonLabel,
    this.onApplyPressed,
  });

  final DashboardJob job;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final sectionTitleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.dialogTitle;
    final valueColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.dialogTitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24.h,
      children: [
        _SidebarCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Text(
                l10n.dashboardJobDetailSidebarTitle,
                style: context.textTheme.labelMedium?.copyWith(
                  color: sectionTitleColor,
                  fontSize: 18.sp,
                ),
              ),
              _DetailField(
                iconPath: Assets.icons.jobDetail.dollar.path,
                label: l10n.dashboardJobDetailSalaryRange,
                value: job.salaryRange,
                valueColor: valueColor,
              ),
              _DetailField(
                iconPath: Assets.icons.jobDetail.employees.path,
                label: l10n.dashboardJobDetailOpeningsLabel,
                value: l10n.dashboardJobDetailPositionsCount(job.openingsCount),
                valueColor: valueColor,
              ),
              _DetailField(
                iconPath: Assets.icons.jobDetail.calendar.path,
                label: l10n.dashboardJobDetailStartDate,
                value: job.startDate,
                valueColor: valueColor,
              ),
              _DetailField(
                iconPath: Assets.icons.dashboard.department.path,
                label: l10n.dashboardJobDetailLevel,
                value: job.level,
                valueColor: valueColor,
              ),
            ],
          ),
        ),
        AppButton(
          label: applyButtonLabel,
          type: AppButtonType.primary,
          onPressed: onApplyPressed,
        ),
        _QuestionsCard(
          title: l10n.dashboardJobDetailQuestionsTitle,
          body: l10n.dashboardJobDetailQuestionsBody,
          email: job.contactEmail,
          isDark: isDark,
          titleColor: sectionTitleColor,
        ),
      ],
    );
  }
}

class _SidebarCard extends StatelessWidget {
  const _SidebarCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.isDark
              ? AppColors.cardBorderDark
              : AppColors.cardBorder,
        ),
      ),
      child: Padding(padding: EdgeInsets.all(25.w), child: child),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({
    required this.iconPath,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String iconPath;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        Row(
          children: [
            AppAsset(
              assetPath: iconPath,
              width: 18.w,
              height: 18.w,
              color: AppColors.textSecondary,
            ),
            Gap(8.w),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: valueColor,
                  fontSize: 16.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuestionsCard extends StatelessWidget {
  const _QuestionsCard({
    required this.title,
    required this.body,
    required this.email,
    required this.isDark,
    required this.titleColor,
  });

  final String title;
  final String body;
  final String email;
  final bool isDark;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.infoBgDark : AppColors.infoBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.infoBorderDark : AppColors.infoBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                color: titleColor,
                fontSize: 18.sp,
              ),
            ),
            Gap(8.h),
            Text(
              body,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Gap(18.h),
            Text(
              email,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
