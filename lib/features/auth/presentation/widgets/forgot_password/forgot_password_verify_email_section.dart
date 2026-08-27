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

class ForgotPasswordVerifyEmailSection extends ConsumerWidget {
  const ForgotPasswordVerifyEmailSection({super.key});

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
              label: l10n.authEmailAddress,
              initialValue: state.email,
              hintText: l10n.authEmailHint,
              isDark: isDark,
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onChanged: controller.onEmailChanged,
              onSubmitted: (_) => controller.sendOtp(l10n),
            ),
            Gap(24.h),
            AppButton(
              label: l10n.authForgotSendCode,
              width: double.infinity,
              isLoading: state.isLoading,
              onPressed: state.canSubmit
                  ? () => controller.sendOtp(l10n)
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
