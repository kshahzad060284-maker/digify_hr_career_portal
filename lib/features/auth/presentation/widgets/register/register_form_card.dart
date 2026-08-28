import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_education_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_header_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_personal_info_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_professional_info_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_security_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_sign_in_prompt.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_social_links_section.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_step_navigation.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_steps_panel.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_work_experience_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormCard extends ConsumerWidget {
  const RegisterFormCard({super.key, this.onSignInTap});

  final VoidCallback? onSignInTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useSidebar = context.registerUsesSidebarStepper;
    final gap = context.registerSectionGap.h;
    final step = ref.watch(registerControllerProvider.select((s) => s.step));

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RegisterFormHeaderSection(),
        Gap(gap),
        if (!useSidebar) ...[const RegisterFormCompactStepsBar(), Gap(gap)],
        Expanded(
          child: useSidebar
              ? _RegisterWizardCard(step: step)
              : _RegisterStepContent(step: step, showHeader: false),
        ),
        Gap(gap),
        RegisterFormSignInPrompt(onSignInTap: onSignInTap),
      ],
    );
  }
}

class _RegisterWizardCard extends StatelessWidget {
  const _RegisterWizardCard({required this.step});

  final RegisterStep step;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final padding = context.registerFormPadding.w;
    final panelWidth = context.registerStepsPanelWidth.w;
    final gap = context.registerSectionGap.h * 0.75;
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundDark.withValues(alpha: 0.45)
            : AppColors.cardBackground.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.all(padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: panelWidth,
              child: const RegisterFormStepsPanel(embedded: true),
            ),
            Gap(24.w),
            VerticalDivider(width: 1.w, thickness: 1, color: borderColor),
            Gap(28.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const RegisterFormStepHeader(),
                  Gap(gap),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _RegisterStepForm(step: step),
                    ),
                  ),
                  Gap(gap),
                  const RegisterFormStepNavigation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterStepContent extends StatelessWidget {
  const _RegisterStepContent({required this.step, required this.showHeader});

  final RegisterStep step;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final gap = context.registerSectionGap.h;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showHeader) ...[const RegisterFormStepHeader(), Gap(gap * 0.75)],
        Expanded(
          child: SingleChildScrollView(
            child: _RegisterFormSurface(child: _RegisterStepForm(step: step)),
          ),
        ),
        Gap(gap),
        const RegisterFormStepNavigation(),
      ],
    );
  }
}

class _RegisterStepForm extends StatelessWidget {
  const _RegisterStepForm({required this.step});

  final RegisterStep step;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      RegisterStep.personalInfo => const RegisterFormPersonalInfoSection(),
      RegisterStep.professionalInfo =>
        const RegisterFormProfessionalInfoSection(),
      RegisterStep.socialLinks => const RegisterFormSocialLinksSection(),
      RegisterStep.education => const RegisterFormEducationSection(),
      RegisterStep.workExperience => const RegisterFormWorkExperienceSection(),
      RegisterStep.security => const RegisterFormSecuritySection(),
    };
  }
}

class _RegisterFormSurface extends StatelessWidget {
  const _RegisterFormSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final padding = context.registerFormPadding.w;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundDark.withValues(alpha: 0.45)
            : AppColors.cardBackground.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(padding: EdgeInsetsDirectional.all(padding), child: child),
    );
  }
}
