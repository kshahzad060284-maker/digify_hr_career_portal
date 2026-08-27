import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgotPasswordSignInPrompt extends StatelessWidget {
  const ForgotPasswordSignInPrompt({super.key, this.onSignInTap});

  final VoidCallback? onSignInTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final baseStyle = context.textTheme.bodyMedium?.copyWith(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(
          height: 1.h,
          thickness: 1,
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                l10n.authForgotRememberPassword,
                style: baseStyle,
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gap(4.w),
            AppButton.text(
              label: l10n.authForgotBackToSignIn,
              onPressed: onSignInTap,
              fontSize: 14.sp,
              foregroundColor: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}
