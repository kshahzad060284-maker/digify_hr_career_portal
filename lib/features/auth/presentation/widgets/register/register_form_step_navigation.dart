import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormStepNavigation extends ConsumerWidget {
  const RegisterFormStepNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    final isLastStep = state.step == RegisterStep.security;
    final isFirstStep = state.step == RegisterStep.personalInfo;

    return Row(
      children: [
        if (!isFirstStep) ...[
          Expanded(
            child: AppButton.outline(
              label: l10n.authBack,
              onPressed: controller.previousStep,
            ),
          ),
          Gap(12.w),
        ],
        Expanded(
          child: AppButton(
            label: isLastStep ? l10n.authCreateAccount : l10n.authContinue,
            width: double.infinity,
            isLoading: isLastStep && state.isLoading,
            onPressed: isLastStep
                ? (state.canSubmit ? () => controller.createAccount() : null)
                : () => controller.nextStep(),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
          ),
        ),
      ],
    );
  }
}
