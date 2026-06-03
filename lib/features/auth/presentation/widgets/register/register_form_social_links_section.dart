import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormSocialLinksSection extends ConsumerWidget {
  const RegisterFormSocialLinksSection({super.key});

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
          l10n.authSocialLinksSection,
          style: context.textTheme.titleLarge?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
          ),
        ),
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authLinkedInProfile,
          initialValue: state.linkedIn,
          hintText: l10n.authLinkedInHint,
          isDark: isDark,
          keyboardType: TextInputType.url,
          onChanged: controller.onLinkedInChanged,
        ),
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authGitHubProfile,
          initialValue: state.github,
          hintText: l10n.authGitHubHint,
          isDark: isDark,
          keyboardType: TextInputType.url,
          onChanged: controller.onGithubChanged,
        ),
        Gap(16.h),
        RegisterAuthField(
          label: l10n.authPortfolioWebsite,
          initialValue: state.portfolio,
          hintText: l10n.authPortfolioHint,
          isDark: isDark,
          keyboardType: TextInputType.url,
          onChanged: controller.onPortfolioChanged,
        ),
      ],
    );
  }
}
