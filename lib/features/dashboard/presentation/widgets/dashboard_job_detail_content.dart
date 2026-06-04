import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/shared/widgets/common/status_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailContent extends StatelessWidget {
  const DashboardJobDetailContent({super.key, required this.job});

  final DashboardJob job;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sectionTitleColor = AppColors.textPrimary;
    final bodyColor = AppColors.textDarkSlate;
    final cardBackgroundColor = context.isDark
        ? AppColors.cardBackgroundDark
        : AppColors.cardBackground;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            _SectionHeading(
              title: l10n.dashboardJobDetailAboutRole,
              fontSize: 20.sp,
              color: sectionTitleColor,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 4.h),
              child: Text(
                job.description,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: bodyColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Gap(12.h),
            _SectionHeading(
              title: l10n.dashboardJobDetailResponsibilities,
              fontSize: 18.sp,
              color: sectionTitleColor,
            ),
            _BulletList(items: job.responsibilities, color: bodyColor),
            Gap(12.h),
            _SectionHeading(
              title: l10n.dashboardJobDetailQualifications,
              fontSize: 18.sp,
              color: sectionTitleColor,
            ),
            _BulletList(items: job.qualifications, color: bodyColor),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.fontSize,
    required this.color,
  });

  final String title;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleSmall?.copyWith(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items, required this.color});

  final List<String> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        for (final item in items) _BulletItem(text: item, color: color),
      ],
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StatusDot(color: color, size: 3.r),
        Gap(8.w),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyLarge?.copyWith(
              color: color,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
