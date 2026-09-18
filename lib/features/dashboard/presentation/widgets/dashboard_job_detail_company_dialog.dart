import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/company_industry_capsule.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Full employer profile, opened from the compact company card.
class DashboardJobDetailCompanyDialog extends StatelessWidget {
  const DashboardJobDetailCompanyDialog({super.key, required this.company});

  final JobCompanyInfo company;

  static Future<void> show(
    BuildContext context, {
    required JobCompanyInfo company,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => DashboardJobDetailCompanyDialog(company: company),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final bodyColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textDarkSlate;
    final labelColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    final name = company.localizedName(isArabic: isArabic);
    final hasInformation = company.information?.trim().isNotEmpty ?? false;

    return AppDialog(
      title: l10n.dashboardJobDetailCompanyTitle,
      subtitle: company.hasName ? name : null,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(
                image: company.logoUrl,
                mimeType: company.logoMimeType,
                fallbackInitial: company.hasName ? name : null,
                size: 52,
              ),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Text(
                      name,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.themeTextPrimary,
                        height: 1.2,
                      ),
                    ),
                    CompanyIndustryCapsule(industry: company.displayIndustry),
                  ],
                ),
              ),
            ],
          ),
          Gap(20.h),
          Divider(height: 1, color: context.themeCardBorder),
          Gap(20.h),
          if (hasInformation) ...[
            _CompanyTextSection(
              label: l10n.dashboardJobDetailCompanyInformationLabel,
              text: company.displayInformation,
              labelColor: labelColor,
              bodyColor: bodyColor,
            ),
            Gap(20.h),
          ],
          _CompanyTextSection(
            label: l10n.dashboardJobDetailCompanyAbout,
            text: company.displayAbout,
            labelColor: labelColor,
            bodyColor: bodyColor,
          ),
        ],
      ),
    );
  }
}

class _CompanyTextSection extends StatelessWidget {
  const _CompanyTextSection({
    required this.label,
    required this.text,
    required this.labelColor,
    required this.bodyColor,
  });

  final String label;
  final String text;
  final Color labelColor;
  final Color bodyColor;

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
            letterSpacing: 0.4,
          ),
        ),
        Gap(8.h),
        Text(
          text,
          style: context.textTheme.bodyLarge?.copyWith(
            color: bodyColor,
            fontSize: 15.sp,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
