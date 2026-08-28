import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormSecuritySection extends ConsumerWidget {
  const RegisterFormSecuritySection({super.key});

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
        RegisterAuthField(
          label: l10n.authPassword,
          initialValue: state.password,
          hintText: l10n.authPasswordHint,
          isDark: isDark,
          isRequired: true,
          obscureText: true,
          onChanged: controller.onPasswordChanged,
        ),
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authConfirmPassword,
          initialValue: state.confirmPassword,
          hintText: l10n.authConfirmPasswordHint,
          isDark: isDark,
          isRequired: true,
          obscureText: true,
          onChanged: controller.onConfirmPasswordChanged,
        ),
      ],
    );
  }
}
