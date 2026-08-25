import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_education_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_header_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_personal_info_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_professional_info_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_security_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_sign_in_prompt.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_social_links_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_work_experience_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormCard extends StatelessWidget {
  const RegisterFormCard({super.key, this.onSignInTap});

  final VoidCallback? onSignInTap;

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
            const _RegisterFormAccentBar(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(28.w, 28.h, 28.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const RegisterFormHeaderSection(),
                  Gap(28.h),
                  const RegisterFormPersonalInfoSection(),
                  Gap(16.h),
                  const RegisterFormProfessionalInfoSection(),
                  Gap(16.h),
                  const RegisterFormSocialLinksSection(),
                  Gap(16.h),
                  const RegisterFormEducationSection(),
                  Gap(16.h),
                  const RegisterFormWorkExperienceSection(),
                  Gap(16.h),
                  const RegisterFormSecuritySection(),
                  Gap(20.h),
                  RegisterFormSignInPrompt(onSignInTap: onSignInTap),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterFormAccentBar extends StatelessWidget {
  const _RegisterFormAccentBar();

  @override
  Widget build(BuildContext context) {
    return Container(height: 4.h, color: AppColors.primary);
  }
}
