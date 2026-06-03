import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/login_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/auth_form_helpers.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginFormCredentialsSection extends ConsumerWidget {
  const LoginFormCredentialsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final isDark = context.isDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthFormField(
          label: l10n.authEmailAddress,
          initialValue: state.email,
          hintText: l10n.authEmailHint,
          isDark: isDark,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: controller.onEmailChanged,
        ),
        Gap(16.h),
        AuthFormField(
          label: l10n.authPassword,
          initialValue: state.password,
          hintText: l10n.authPasswordHint,
          isDark: isDark,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onChanged: controller.onPasswordChanged,
          onSubmitted: (_) => controller.signIn(),
        ),
        Gap(16.h),
        AppButton(
          label: l10n.signIn,
          width: double.infinity,
          isLoading: state.isLoading,
          onPressed: state.canSubmit ? controller.signIn : null,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
        ),
      ],
    );
  }
}
