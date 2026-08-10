import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_employer_info_provider.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:career_portal/shared/widgets/common/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardHeaderBrand extends ConsumerWidget {
  const DashboardHeaderBrand({
    super.key,
    required this.titleColor,
    required this.taglineColor,
    required this.logoSize,
    required this.titleFontSize,
    this.titleMaxLines,
    this.taglineMaxLines,
  });

  final Color titleColor;
  final Color taglineColor;
  final double logoSize;
  final double titleFontSize;
  final int? titleMaxLines;
  final int? taglineMaxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final enterpriseName = ref.watch(hostEnterpriseNameProvider);
    final employerInfo = ref
        .watch(enterpriseEmployerInfoProvider)
        .asData
        ?.value;

    final title = (enterpriseName != null && enterpriseName.isNotEmpty)
        ? l10n.enterpriseCareerPortalTitle(enterpriseName)
        : l10n.appTitle;

    return Row(
      children: [
        AppAvatar(
          image: employerInfo?.logoUrl,
          fallbackInitial: enterpriseName ?? title,
          size: logoSize.r,
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: titleMaxLines,
                overflow: titleMaxLines == null ? null : TextOverflow.ellipsis,
                style: context.textTheme.titleLarge?.copyWith(
                  color: titleColor,
                  fontSize: titleFontSize,
                ),
              ),
              Gap(2.h),
              Text(
                l10n.appTagline,
                maxLines: taglineMaxLines,
                overflow: taglineMaxLines == null
                    ? null
                    : TextOverflow.ellipsis,
                style: context.textTheme.labelSmall?.copyWith(
                  color: taglineColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
