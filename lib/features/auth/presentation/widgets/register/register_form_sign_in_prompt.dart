import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormSignInPrompt extends StatelessWidget {
  const RegisterFormSignInPrompt({super.key, this.onSignInTap});

  final VoidCallback? onSignInTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final baseStyle = context.textTheme.bodyMedium?.copyWith(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.authAlreadyHaveAccountPrompt,
          style: baseStyle,
          textAlign: TextAlign.center,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        Gap(4.w),
        AppButton.text(
          label: l10n.signIn,
          onPressed: onSignInTap,
          fontSize: 14.sp,
          foregroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
