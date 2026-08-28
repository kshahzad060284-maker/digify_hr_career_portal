import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/domain/config/auth_form_config.dart';
import 'package:career_portal/features/auth/presentation/config/register_form_config.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_phone_field.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormPersonalInfoSection extends ConsumerWidget {
  const RegisterFormPersonalInfoSection({super.key});

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
              label: l10n.authFirstName,
              initialValue: state.firstName,
              hintText: l10n.authFirstNameHint,
              isDark: isDark,
              isRequired: true,
              onChanged: controller.onFirstNameChanged,
            ),
            RegisterAuthField(
              label: l10n.authMiddleName,
              initialValue: state.middleName,
              hintText: l10n.authMiddleNameHint,
              isDark: isDark,
              onChanged: controller.onMiddleNameChanged,
            ),
            RegisterAuthField(
              label: l10n.authLastName,
              initialValue: state.lastName,
              hintText: l10n.authLastNameHint,
              isDark: isDark,
              isRequired: true,
              onChanged: controller.onLastNameChanged,
            ),
          ],
        ),
        Gap(20.h),
        RegisterResponsiveRow(
          children: [
            RegisterAuthField(
              label: l10n.authEmailAddress,
              initialValue: state.email,
              hintText: l10n.authEmailHint,
              isDark: isDark,
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: controller.onEmailChanged,
            ),
            RegisterAuthField(
              label: l10n.authAlternateEmail,
              initialValue: state.alternateEmail,
              hintText: l10n.authAlternateEmailHint,
              isDark: isDark,
              keyboardType: TextInputType.emailAddress,
              onChanged: controller.onAlternateEmailChanged,
            ),
          ],
        ),
        Gap(20.h),
        RegisterResponsiveRow(
          children: [
            AppPhoneField(
              labelText: l10n.authPhoneNumber,
              hintText: l10n.authPhoneHint,
              isRequired: true,
              initialDialCode: state.phoneDialCode,
              initialNumber: state.phone,
              onDialCodeChanged: controller.onPhoneDialCodeChanged,
              onNumberChanged: controller.onPhoneNumberChanged,
            ),
            AppPhoneField(
              labelText: l10n.authAlternatePhone,
              hintText: l10n.authPhoneHint,
              initialDialCode: state.alternatePhoneDialCode,
              initialNumber: state.alternatePhone,
              onDialCodeChanged: controller.onAlternatePhoneDialCodeChanged,
              onNumberChanged: controller.onAlternatePhoneNumberChanged,
            ),
          ],
        ),
        Gap(20.h),
        RegisterResponsiveRow(
          children: [
            AppDateField(
              label: l10n.authDateOfBirth,
              hintText: l10n.authDateHint,
              initialDate: state.dateOfBirth,
              firstDate: AuthFormConfig.formDateFirst,
              lastDate: DateTime.now(),
              fillColor: fillColor,
              onDateSelected: controller.onDateOfBirthChanged,
            ),
            AppSelectFieldWithLabel<RegisterGender>(
              label: l10n.authGender,
              hint: l10n.authSelectGender,
              value: state.gender,
              items: RegisterFormConfig.genderOptions,
              itemLabelBuilder: (gender) =>
                  RegisterFormConfig.genderLabel(l10n, gender),
              fillColor: fillColor,
              onChanged: controller.onGenderChanged,
            ),
          ],
        ),
        Gap(20.h),
        RegisterAuthField(
          label: l10n.authNationality,
          initialValue: state.nationality,
          hintText: l10n.authNationalityHint,
          isDark: isDark,
          isRequired: true,
          onChanged: controller.onNationalityChanged,
        ),
      ],
    );
  }
}
