import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/auth_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgotPasswordResetSection extends ConsumerWidget {
  const ForgotPasswordResetSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final state = ref.watch(forgotPasswordControllerProvider);
    final controller = ref.read(forgotPasswordControllerProvider.notifier);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 16.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthFormField(
              label: l10n.authForgotNewPassword,
              initialValue: state.password,
              hintText: l10n.authForgotNewPasswordHint,
              isDark: isDark,
              isRequired: true,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onChanged: controller.onPasswordChanged,
            ),
            Gap(16.h),
            AuthFormField(
              label: l10n.authConfirmPassword,
              initialValue: state.confirmPassword,
              hintText: l10n.authConfirmPasswordHint,
              isDark: isDark,
              isRequired: true,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onChanged: controller.onConfirmPasswordChanged,
              onSubmitted: (_) => controller.resetPassword(l10n),
            ),
            Gap(24.h),
            AppButton(
              label: l10n.authForgotResetPassword,
              width: double.infinity,
              isLoading: state.isLoading,
              onPressed: state.canSubmit
                  ? () => controller.resetPassword(l10n)
                  : null,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
