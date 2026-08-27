import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_employer_info_provider.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:career_portal/shared/widgets/common/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginFormHeaderSection extends ConsumerWidget {
  const LoginFormHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final name = ref.watch(hostEnterpriseNameProvider) ?? l10n.appTitle;
    final employerInfo = ref
        .watch(enterpriseEmployerInfoProvider)
        .asData
        ?.value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: AppAvatar(
            image: employerInfo?.logoUrl,
            mimeType: employerInfo?.logoMimeType,
            fallbackInitial: name,
            size: 64.w,
            backgroundColor: AppColors.cardBackground,
            border: Border.all(color: AppColors.cardBorder),
          ),
        ),
        Gap(16.h),
        Text(
          l10n.authSignInTitle(name),
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 20.sp,
            color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
          ),
        ),
        Gap(8.h),
        Text(
          l10n.authSignInSubtitle,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
