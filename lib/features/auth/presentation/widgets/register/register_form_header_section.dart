import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormHeaderSection extends StatelessWidget {
  const RegisterFormHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(alignment: Alignment.center, child: RegisterIconCircle()),
        Gap(8.h),
        Text(
          l10n.authCreateAccountTitle,
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 20.sp,
            color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
          ),
        ),
        Gap(8.h),
        Text(
          l10n.authCreateAccountSubtitle,
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
