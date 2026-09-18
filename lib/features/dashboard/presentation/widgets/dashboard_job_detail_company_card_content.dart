import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/company_industry_capsule.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_company_dialog.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Minimal employer summary: identity plus an action opening the full profile.
///
/// Set [embedded] when the caller already provides the card surface, as the
/// job detail sidebar does.
class DashboardJobDetailCompanyCardContent extends StatelessWidget {
  const DashboardJobDetailCompanyCardContent({
    super.key,
    required this.company,
    this.embedded = false,
  });

  final JobCompanyInfo company;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final name = company.localizedName(isArabic: isArabic);

    final content = Padding(
      padding: EdgeInsets.all(embedded ? 22.w : 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                image: company.logoUrl,
                mimeType: company.logoMimeType,
                fallbackInitial: company.hasName ? name : null,
                size: 56,
                border: Border.all(color: context.themeCardBorder, width: 0.8),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Text(
                      l10n.dashboardJobDetailCompanyTitle,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: isDark
                            ? AppColors.textTertiaryDark
                            : AppColors.textSecondary,
                        fontSize: 11.sp,
                        letterSpacing: 0.6,
                      ),
                    ),
                    Text(
                      name,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.themeTextPrimary,
                        fontSize: 15.sp,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CompanyIndustryCapsule(industry: company.displayIndustry),
              AppButton(
                label: l10n.dashboardJobDetailCompanyViewDetails,
                type: AppButtonType.text,
                shrinkWrap: true,
                fontSize: 12.sp,
                height: 20.h,
                padding: EdgeInsets.zero,
                foregroundColor: AppColors.primary,
                onPressed: () => DashboardJobDetailCompanyDialog.show(
                  context,
                  company: company,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (embedded) return content;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.themeCardBorder),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: content,
    );
  }
}
