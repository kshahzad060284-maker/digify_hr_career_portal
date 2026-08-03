import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailContent extends StatelessWidget {
  const DashboardJobDetailContent({
    super.key,
    required this.job,
    this.hasApplied = false,
  });

  final DashboardJob job;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final sectionTitleColor = context.themeTextPrimary;
    final bodyColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textDarkSlate;
    final cardBackgroundColor = context.themeCardBackground;
    final borderColor = context.themeCardBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: borderColor),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowColor.withValues(alpha: 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: EdgeInsets.all(context.isMobileLayout ? 20.w : 28.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeading(
              title: l10n.dashboardJobDetailAboutRole,
              color: sectionTitleColor,
              accentColor: AppColors.primary,
            ),
            Gap(12.h),
            Text(
              job.description,
              style: context.textTheme.bodyLarge?.copyWith(
                color: bodyColor,
                fontSize: 15.sp,
                height: 1.65,
              ),
            ),
            if (job.responsibilities.isNotEmpty) ...[
              Gap(28.h),
              _SectionDivider(color: borderColor),
              Gap(24.h),
              _SectionHeading(
                title: l10n.dashboardJobDetailResponsibilities,
                color: sectionTitleColor,
                accentColor: AppColors.primary,
              ),
              Gap(14.h),
              _ContentList(items: job.responsibilities, color: bodyColor),
            ],
            if (job.qualifications.isNotEmpty) ...[
              Gap(28.h),
              _SectionDivider(color: borderColor),
              Gap(24.h),
              _SectionHeading(
                title: l10n.dashboardJobDetailQualifications,
                color: sectionTitleColor,
                accentColor: AppColors.success,
              ),
              Gap(14.h),
              _ContentList(items: job.qualifications, color: bodyColor),
            ],
            Gap(28.h),
            _SectionDivider(color: borderColor),
            Gap(24.h),
            _SectionHeading(
              title: l10n.dashboardJobDetailTags,
              color: sectionTitleColor,
              accentColor: AppColors.primary,
            ),
            Gap(14.h),
            _JobTags(
              job: job,
              hasApplied: hasApplied,
              l10n: l10n,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _JobTags extends StatelessWidget {
  const _JobTags({
    required this.job,
    required this.hasApplied,
    required this.l10n,
    required this.isDark,
  });

  final DashboardJob job;
  final bool hasApplied;
  final AppLocalizations l10n;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
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
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            textStyle: context.textTheme.labelSmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.brandRed,
            ),
          ),
        if (hasApplied)
          AppCapsule(
            label: l10n.dashboardJobApplicationStatusApplied,
            backgroundColor: isDark
                ? AppColors.successBg.withValues(alpha: 0.18)
                : AppColors.successBg,
            textColor: isDark
                ? AppColors.successTextDark
                : AppColors.successText,
            borderColor: isDark
                ? AppColors.successBorder.withValues(alpha: 0.35)
                : AppColors.successBorder,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            textStyle: context.textTheme.labelSmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.successTextDark : AppColors.successText,
            ),
          ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.color,
    required this.accentColor,
  });

  final String title;
  final Color color;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: SizedBox(width: 4.w, height: 20.h),
        ),
        Gap(10.w),
        Expanded(
          child: Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              color: color,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: color);
  }
}

class _ContentList extends StatelessWidget {
  const _ContentList({required this.items, required this.color});

  final List<String> items;
  final Color color;

  String _cleanItem(String item) {
    return item
        .replaceFirst(RegExp(r'^[\s•\-\*\u2022\u25CF\u25E6]+'), '')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final markerColor = context.isDark
        ? AppColors.primaryLight
        : AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        for (final item in items)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(top: 2.h),
                child: Icon(
                  Icons.check_rounded,
                  size: 18.sp,
                  color: markerColor,
                ),
              ),
              Gap(10.w),
              Expanded(
                child: Text(
                  _cleanItem(item),
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: color,
                    fontSize: 15.sp,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
