import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterFormSocialLinksSection extends ConsumerWidget {
  const RegisterFormSocialLinksSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    final isDark = context.isDark;

    return RegisterFormSectionPanel(
      step: 3,
      title: l10n.authSocialLinksSection,
      child: RegisterAuthField(
        label: l10n.authLinkedInProfile,
        initialValue: state.linkedIn,
        hintText: l10n.authLinkedInHint,
        isDark: isDark,
        keyboardType: TextInputType.url,
        onChanged: controller.onLinkedInChanged,
      ),
    );
  }
}
