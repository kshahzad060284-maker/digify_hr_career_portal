import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_phone_field.dart';
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
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authEmailAddress,
          initialValue: state.email,
          hintText: l10n.authEmailHint,
          isDark: isDark,
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
          onChanged: controller.onEmailChanged,
        ),
        Gap(16.h),
        AppPhoneField(
          labelText: l10n.authPhoneNumber,
          hintText: l10n.authPhoneHint,
          isRequired: true,
          initialDialCode: state.phoneDialCode,
          initialNumber: state.phone,
          onDialCodeChanged: controller.onPhoneDialCodeChanged,
          onNumberChanged: controller.onPhoneNumberChanged,
        ),
      ],
    );
  }
}
