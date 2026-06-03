import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/features/auth/presentation/layouts/auth_layout.dart';
import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/features/auth/presentation/providers/login_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/login/login_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen(loginControllerProvider, (previous, next) {
      if (next.toastEventId == (previous?.toastEventId ?? 0) ||
          next.toastType == null) {
        return;
      }
      final message = switch (next.toastType!) {
        LoginToastType.emailRequired => l10n.authEmailRequired,
        LoginToastType.emailInvalid => l10n.authEmailInvalid,
        LoginToastType.passwordRequired => l10n.authPasswordRequired,
        LoginToastType.signInFailed => l10n.authSignInFailed,
      };
      ToastService.error(context, message);
    });

    return AuthLayout(
      child: LoginFormCard(
        onRegisterTap: () => context.go(AppRoutes.authSignUp),
      ),
    );
  }
}
