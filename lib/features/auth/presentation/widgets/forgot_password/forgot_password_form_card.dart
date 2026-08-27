import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_header_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_otp_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_reset_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_sign_in_prompt.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_steps_panel.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_verify_email_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgotPasswordFormCard extends ConsumerWidget {
  const ForgotPasswordFormCard({super.key, this.onSignInTap});

  final VoidCallback? onSignInTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final step = ref.watch(
      forgotPasswordControllerProvider.select((s) => s.step),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
        boxShadow: AppShadows.primaryShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 4.h, color: AppColors.primary),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(28.w, 28.h, 28.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ForgotPasswordHeaderSection(),
                  Gap(28.h),
                  if (isMobile) ...[
                    const ForgotPasswordMobileStepsBar(),
                    Gap(20.h),
                    _stepForm(step),
                  ] else
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 3, child: _stepForm(step)),
                          Gap(20.w),
                          VerticalDivider(
                            width: 1.w,
                            thickness: 1,
                            color: isDark
                                ? AppColors.cardBorderDark
                                : AppColors.cardBorder,
                          ),
                          Gap(20.w),
                          const Expanded(
                            flex: 2,
                            child: ForgotPasswordStepsPanel(),
                          ),
                        ],
                      ),
                    ),
                  Gap(20.h),
                  ForgotPasswordSignInPrompt(onSignInTap: onSignInTap),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepForm(ForgotPasswordStep step) {
    return switch (step) {
      ForgotPasswordStep.verifyEmail =>
        const ForgotPasswordVerifyEmailSection(),
      ForgotPasswordStep.checkOtp => const ForgotPasswordOtpSection(),
      ForgotPasswordStep.resetPassword => const ForgotPasswordResetSection(),
    };
  }
}
