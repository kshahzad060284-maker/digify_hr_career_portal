import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/auth/presentation/widgets/login/login_form_credentials_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/login/login_form_header_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/login/login_form_register_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({super.key, this.onRegisterTap});

  final VoidCallback? onRegisterTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

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
            const _LoginFormAccentBar(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(28.w, 28.h, 28.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginFormHeaderSection(),
                  Gap(28.h),
                  const LoginFormCredentialsSection(),
                  Gap(20.h),
                  LoginFormRegisterPrompt(onRegisterTap: onRegisterTap),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginFormAccentBar extends StatelessWidget {
  const _LoginFormAccentBar();

  @override
  Widget build(BuildContext context) {
    return Container(height: 4.h, color: AppColors.primary);
  }
}
