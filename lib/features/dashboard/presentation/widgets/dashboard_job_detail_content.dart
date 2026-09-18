import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'dashboard_job_detail_content_formatter.dart';

class DashboardJobDetailContent extends StatelessWidget {
  const DashboardJobDetailContent({
    super.key,
    required this.job,
    required this.hasApplied,
    this.showSurface = false,
  });

  final DashboardJob job;
  final bool hasApplied;
  final bool showSurface;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final bodyColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textDarkSlate;

    final content = Padding(
      padding: EdgeInsets.all(context.isMobileLayout ? 20.w : 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionBlock(
            heading: l10n.dashboardJobDetailAboutRole,
            child: Text(
              job.description,
              style: context.textTheme.bodyLarge?.copyWith(color: bodyColor),
            ),
          ),
          if (job.responsibilities.isNotEmpty) ...[
            _SectionDivider(),
            _SectionBlock(
              heading: l10n.dashboardJobDetailResponsibilities,
              child: _ContentList(
                items: job.responsibilities,
                color: bodyColor,
              ),
            ),
          ],
          if (job.qualifications.isNotEmpty) ...[
            _SectionDivider(),
            _SectionBlock(
              heading: l10n.dashboardJobDetailQualifications,
              child: _ContentList(items: job.qualifications, color: bodyColor),
            ),
          ],
          _SectionDivider(),
          _SectionBlock(
            heading: l10n.dashboardJobDetailTags,
            child: _JobTags(
              job: job,
              hasApplied: hasApplied,
              l10n: l10n,
              isDark: isDark,
            ),
          ),
        ],
      ),
    );

    if (!showSurface) return content;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.themeCardBorder),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: content,
    );
  }
}

class _SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28.h),
      child: Divider(height: 1, color: context.themeCardBorder),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({required this.heading, required this.child});

  final String heading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 4.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
            Gap(10.w),
            Text(
              heading,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.themeTextPrimary,
              ),
            ),
          ],
        ),
        Gap(16.h),
        child,
      ],
    );
  }
}

class _ContentList extends StatelessWidget {
  const _ContentList({required this.items, required this.color});

  final List<String> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final markerColor = context.isDark
        ? AppColors.textTertiaryDark
        : AppColors.textPlaceholder;

    final merged = mergeDashboardJobContentFragments(items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14.h,
      children: [
        for (final item in merged)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.h),
                child: Icon(
                  Icons.check_rounded,
                  size: 14.sp,
                  color: markerColor,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Text(
                  item,
                  style: context.textTheme.bodyLarge?.copyWith(color: color),
                ),
              ),
            ],
          ),
      ],
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
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          textStyle: context.textTheme.labelMedium?.copyWith(
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            textStyle: context.textTheme.labelMedium?.copyWith(
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            textStyle: context.textTheme.labelMedium?.copyWith(
              color: isDark ? AppColors.successTextDark : AppColors.successText,
            ),
          ),
      ],
    );
  }
}
