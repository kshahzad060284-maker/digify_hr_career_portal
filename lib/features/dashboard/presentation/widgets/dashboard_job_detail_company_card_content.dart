import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailCompanyCardContent extends StatelessWidget {
  const DashboardJobDetailCompanyCardContent({
    super.key,
    required this.company,
  });

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

    final name = company.localizedName(isArabic: isArabic);

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
            _CompanyIdentity(
              name: name,
              logoUrl: company.logoUrl,
              logoMimeType: company.logoMimeType,
              industry: company.displayIndustry,
              hasName: company.hasName,
            ),
            Gap(20.h),
            // Text(
            //   company.displayInformation,
            //   style: context.textTheme.bodyLarge?.copyWith(
            //     color: bodyColor,
            //     fontSize: 15.sp,
            //   ),
            // ),
            // Gap(16.h),
            Text(
              l10n.dashboardJobDetailCompanyAbout,
              style: context.textTheme.labelLarge?.copyWith(
                color: labelColor,
                fontSize: 12.sp,
              ),
            ),
            Gap(8.h),
            Text(
              company.displayAbout,
              style: context.textTheme.bodyLarge?.copyWith(
                color: bodyColor,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyIdentity extends StatelessWidget {
  const _CompanyIdentity({
    required this.name,
    required this.logoUrl,
    required this.logoMimeType,
    required this.industry,
    required this.hasName,
  });

  final String name;
  final String? logoUrl;
  final String? logoMimeType;
  final String industry;
  final bool hasName;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final logoSize = isMobile ? 56.0 : 64.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppAvatar(
          image: logoUrl,
          mimeType: logoMimeType,
          fallbackInitial: hasName ? name : null,
          size: logoSize,
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
