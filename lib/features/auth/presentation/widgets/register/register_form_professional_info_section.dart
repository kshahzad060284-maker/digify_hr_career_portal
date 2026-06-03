import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_radio_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormProfessionalInfoSection extends ConsumerWidget {
  const RegisterFormProfessionalInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    final isDark = context.isDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.authProfessionalInformation,
          style: context.textTheme.titleLarge?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
          ),
        ),
        Gap(16.h),
        RegisterResponsiveRow(
          children: [
            RegisterAuthField(
              label: l10n.authCurrentCompany,
              initialValue: state.currentCompany,
              hintText: l10n.authCurrentCompanyHint,
              isDark: isDark,
              onChanged: controller.onCurrentCompanyChanged,
            ),
            RegisterAuthField(
              label: l10n.authCurrentTitle,
              initialValue: state.currentTitle,
              hintText: l10n.authCurrentTitleHint,
              isDark: isDark,
              onChanged: controller.onCurrentTitleChanged,
            ),
          ],
        ),
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authTotalExperience,
          initialValue: state.totalExperience,
          hintText: l10n.authTotalExperienceHint,
          isDark: isDark,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: controller.onTotalExperienceChanged,
        ),
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authCurrentLocation,
          initialValue: state.currentLocation,
          hintText: l10n.authLocationHint,
          isDark: isDark,
          onChanged: controller.onCurrentLocationChanged,
        ),
        Gap(16.h),
        Text(
          l10n.authWillingToRelocate,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.inputLabel,
          ),
        ),
        Gap(8.h),
        Wrap(
          spacing: 16.w,
          children: [
            AppRadioOption(
              label: l10n.authYes,
              selected:
                  state.willingToRelocate == RegisterRelocatePreference.yes,
              onTap: () => controller.onWillingToRelocateChanged(
                RegisterRelocatePreference.yes,
              ),
            ),
            AppRadioOption(
              label: l10n.authNo,
              selected:
                  state.willingToRelocate == RegisterRelocatePreference.no,
              onTap: () => controller.onWillingToRelocateChanged(
                RegisterRelocatePreference.no,
              ),
            ),
          ],
        ),
        Gap(16.h),
        RegisterResponsiveRow(
          children: [
            RegisterAuthField(
              label: l10n.authCurrentSalaryOptional,
              initialValue: state.currentSalary,
              hintText: l10n.authSalaryExampleHint,
              isDark: isDark,
              keyboardType: TextInputType.number,
              onChanged: controller.onCurrentSalaryChanged,
            ),
            RegisterAuthField(
              label: l10n.authExpectedSalaryOptional,
              initialValue: state.expectedSalary,
              hintText: l10n.authExpectedSalaryExampleHint,
              isDark: isDark,
              keyboardType: TextInputType.number,
              onChanged: controller.onExpectedSalaryChanged,
            ),
          ],
        ),
      ],
    );
  }
}
