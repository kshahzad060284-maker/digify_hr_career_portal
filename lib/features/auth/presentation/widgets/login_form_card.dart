import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/login_provider.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginFormCard extends ConsumerWidget {
  const LoginFormCard({super.key, this.onRegisterTap});

  final VoidCallback? onRegisterTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final loginState = ref.watch(loginControllerProvider);
    final loginController = ref.read(loginControllerProvider.notifier);
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(33.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(alignment: Alignment.center, child: _LoginIconCircle()),
            Gap(8.h),
            Text(
              l10n.authWelcomeBack,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: 20.sp,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.dialogTitle,
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
            Gap(24.h),
            _AuthField(
              label: l10n.authEmailAddress,
              initialValue: loginState.email,
              hintText: l10n.authEmailHint,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: loginController.onEmailChanged,
              isDark: isDark,
            ),
            Gap(16.h),
            _AuthField(
              label: l10n.authPassword,
              initialValue: loginState.password,
              hintText: l10n.authPasswordHint,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onChanged: loginController.onPasswordChanged,
              onSubmitted: (_) => loginController.signIn(),
              isDark: isDark,
            ),
            Gap(16.h),
            AppButton(
              label: l10n.signIn,
              width: double.infinity,
              isLoading: loginState.isLoading,
              onPressed: loginState.canSubmit ? loginController.signIn : null,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            Gap(24.h),
            _RegisterPrompt(
              prompt: l10n.authNoAccountPrompt,
              actionLabel: l10n.authRegisterNow,
              onRegisterTap: onRegisterTap,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginIconCircle extends StatelessWidget {
  const _LoginIconCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: const BoxDecoration(
        color: AppColors.authIconCircleBg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: AppAsset(
        assetPath: Assets.icons.auth.login.path,
        width: 32.w,
        height: 32.w,
        color: AppColors.primary,
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.label,
    required this.initialValue,
    required this.isDark,
    required this.onChanged,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label;
  final String initialValue;
  final bool isDark;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      initialValue: initialValue,
      labelText: label,
      hintText: hintText,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      filled: true,
      fillColor: isDark ? AppColors.inputBgDark : AppColors.authInputFill,
      borderColor: isDark
          ? AppColors.inputBorderDark
          : AppColors.authInputBorder,
      focusedBorderColor: AppColors.primary,
    );
  }
}

class _RegisterPrompt extends StatelessWidget {
  const _RegisterPrompt({
    required this.prompt,
    required this.actionLabel,
    required this.isDark,
    this.onRegisterTap,
  });

  final String prompt;
  final String actionLabel;
  final bool isDark;
  final VoidCallback? onRegisterTap;

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.textTheme.bodyMedium?.copyWith(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: baseStyle, textAlign: TextAlign.center),
        AppButton.text(
          label: actionLabel,
          onPressed: onRegisterTap,
          fontSize: 14.sp,
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.zero,
          height: 20.h,
        ),
      ],
    );
  }
}
