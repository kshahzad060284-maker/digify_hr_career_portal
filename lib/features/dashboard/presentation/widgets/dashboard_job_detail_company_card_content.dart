import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_section_heading.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailCompanyCardContent extends StatelessWidget {
  const DashboardJobDetailCompanyCardContent({
    super.key,
    required this.company,
  });

  static const String missingValue = '---';

  final JobCompanyInfo company;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final bodyColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textDarkSlate;
    final labelColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    final name = _displayValue(company.localizedName(isArabic: isArabic));
    final industry = _displayValue(company.industry);
    final information = _displayValue(company.information);
    final about = _displayValue(company.about);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.themeCardBorder),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20.w : 28.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardJobDetailSectionHeading(
              title: l10n.dashboardJobDetailCompanyTitle,
            ),
            Gap(20.h),
            _CompanyIdentity(
              name: name,
              logoUrl: company.logoUrl,
              industry: industry,
            ),
            Gap(20.h),
            _LabeledTextBlock(
              label: l10n.dashboardJobDetailCompanyInformationLabel,
              value: information,
              labelColor: labelColor,
              valueColor: bodyColor,
            ),
            Gap(20.h),
            const AppDivider.horizontal(),
            Gap(20.h),
            _LabeledTextBlock(
              label: l10n.dashboardJobDetailCompanyAbout,
              value: about,
              labelColor: labelColor,
              valueColor: bodyColor,
            ),
          ],
        ),
      ),
    );
  }

  static String _displayValue(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return missingValue;
    return trimmed;
  }
}

class _CompanyIdentity extends StatelessWidget {
  const _CompanyIdentity({
    required this.name,
    required this.logoUrl,
    required this.industry,
  });

  final String name;
  final String? logoUrl;
  final String industry;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final logoSize = isMobile ? 56.0 : 64.0;
    final fallbackName =
        name == DashboardJobDetailCompanyCardContent.missingValue ? null : name;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppAvatar(
          image: logoUrl,
          fallbackInitial: fallbackName,
          size: logoSize,
          border: Border.all(color: AppColors.primaryLight, width: 1),
        ),
        Gap(14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Text(
                name,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.themeTextPrimary,
                  fontSize: isMobile ? 18.sp : 20.sp,
                ),
              ),
              AppCapsule(
                label: industry,
                backgroundColor: isDark
                    ? AppColors.purpleBgDark.withValues(alpha: 0.35)
                    : AppColors.purpleBg,
                textColor: isDark
                    ? AppColors.purpleTextDark
                    : AppColors.purpleText,
                borderColor: isDark
                    ? AppColors.purpleBorderDark.withValues(alpha: 0.45)
                    : AppColors.purpleBorder,
                textStyle: context.textTheme.labelLarge?.copyWith(
                  fontSize: 12.sp,
                  color: isDark
                      ? AppColors.purpleTextDark
                      : AppColors.purpleText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabeledTextBlock extends StatelessWidget {
  const _LabeledTextBlock({
    required this.label,
    required this.value,
    required this.labelColor,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            color: labelColor,
            fontSize: 12.sp,
          ),
        ),
        Gap(8.h),
        Text(
          value,
          style: context.textTheme.bodyLarge?.copyWith(
            color: valueColor,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
