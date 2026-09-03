import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/extensions/number_formatting_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/utils/field_formatters.dart';
import 'package:career_portal/features/auth/presentation/config/register_form_config.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_radio_option.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:digify_core/widgets/forms/location_selection_field.dart';
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
    final fillColor = isDark ? AppColors.inputBgDark : AppColors.cardBackground;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        RegisterResponsiveRow(
          children: [
            RegisterAuthField(
              label: l10n.authTotalExperience,
              initialValue: state.totalExperience,
              hintText: l10n.authTotalExperienceHint,
              isDark: isDark,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: controller.onTotalExperienceChanged,
            ),
            RegisterAuthField(
              label: l10n.authNoticePeriod,
              initialValue: state.noticePeriod,
              hintText: l10n.authNoticePeriodHint,
              isDark: isDark,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: controller.onNoticePeriodChanged,
            ),
          ],
        ),
        Gap(16.h),
        RegisterResponsiveRow(
          children: [
            LocationSelectionField(
              label: l10n.authCurrentLocation,
              hint: l10n.authLocationHint,
              value: state.currentLocation,
              isRequired: true,
              fillColor: fillColor,
              onChanged: (option) =>
                  controller.onCurrentLocationChanged(option?.meaningEn ?? ''),
            ),
            LocationSelectionField(
              label: l10n.authPreferredLocation,
              hint: l10n.authPreferredLocationHint,
              value: state.preferredLocation,
              fillColor: fillColor,
              onChanged: (option) => controller.onPreferredLocationChanged(
                option?.meaningEn ?? '',
              ),
            ),
          ],
        ),
        Gap(16.h),
        RegisterResponsiveRow(
          children: [
            AppSelectFieldWithLabel<RegisterVisaStatus>(
              label: l10n.authVisaStatus,
              hint: l10n.authSelectVisaStatus,
              value: state.visaStatus,
              items: RegisterFormConfig.visaStatusOptions,
              itemLabelBuilder: (status) =>
                  RegisterFormConfig.visaStatusLabel(l10n, status),
              fillColor: fillColor,
              onChanged: controller.onVisaStatusChanged,
            ),
            RegisterAuthField(
              label: l10n.authSource,
              initialValue: state.source,
              hintText: l10n.authSourceHint,
              isDark: isDark,
              onChanged: controller.onSourceChanged,
            ),
          ],
        ),
        Gap(16.h),
        Text(
          l10n.authWillingToRelocate,
          style: context.textTheme.titleSmall?.copyWith(
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
              initialValue: _formattedSalary(state.currentSalary),
              hintText: l10n.authSalaryExampleHint,
              isDark: isDark,
              keyboardType: TextInputType.number,
              inputFormatters: FieldFormat.commaSeparatedNumberFormatters,
              onChanged: controller.onCurrentSalaryChanged,
            ),
            RegisterAuthField(
              label: l10n.authExpectedSalaryOptional,
              initialValue: _formattedSalary(state.expectedSalary),
              hintText: l10n.authExpectedSalaryExampleHint,
              isDark: isDark,
              keyboardType: TextInputType.number,
              inputFormatters: FieldFormat.commaSeparatedNumberFormatters,
              onChanged: controller.onExpectedSalaryChanged,
            ),
          ],
        ),
      ],
    );
  }

  String _formattedSalary(String value) {
    final parsed = value.parseCommaSeparated();
    if (parsed == null) return '';
    return parsed.toCommaSeparated(trimZeros: true);
  }
}
