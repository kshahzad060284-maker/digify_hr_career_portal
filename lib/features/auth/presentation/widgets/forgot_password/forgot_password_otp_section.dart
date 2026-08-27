import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/auth_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgotPasswordOtpSection extends ConsumerWidget {
  const ForgotPasswordOtpSection({super.key});

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
            Text(
              l10n.authForgotOtpBody(state.email.trim()),
              style: context.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            Gap(16.h),
            AuthFormField(
              label: l10n.authForgotOtpLabel,
              initialValue: state.otp,
              hintText: l10n.authForgotOtpHint,
              isDark: isDark,
              isRequired: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: controller.onOtpChanged,
              onSubmitted: (_) => controller.verifyOtp(l10n),
            ),
            Gap(8.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AppButton.text(
                label: state.canResendOtp
                    ? l10n.authForgotResendOtp
                    : l10n.authForgotResendOtpIn(state.resendCooldownSeconds),
                onPressed: state.canResendOtp
                    ? () => controller.resendOtp(l10n)
                    : null,
                fontSize: 13.sp,
                foregroundColor: AppColors.primary,
                shrinkWrap: true,
              ),
            ),
            Gap(16.h),
            AppButton(
              label: l10n.authForgotVerifyOtp,
              width: double.infinity,
              isLoading: state.isLoading,
              onPressed: state.canSubmit
                  ? () => controller.verifyOtp(l10n)
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
