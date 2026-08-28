import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/features/auth/presentation/layouts/auth_layout.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen(registerControllerProvider, (previous, next) {
      if (next.registerSuccessEventId !=
          (previous?.registerSuccessEventId ?? 0)) {
        ToastService.success(context, l10n.authCreateAccountSuccess);
        context.go(AppRoutes.authLogin);
        return;
      }

      if (next.toastEventId == (previous?.toastEventId ?? 0) ||
          next.toastType == null) {
        return;
      }
      final controller = ref.read(registerControllerProvider.notifier);
      final message = switch (next.toastType!) {
        RegisterToastType.createAccountFailed =>
          next.registerFailureMessage ?? l10n.authCreateAccountFailed,
        _ => controller.toastMessage(l10n, next.toastType!),
      };
      if (controller.isInfoToast(next.toastType!)) {
        ToastService.info(context, message);
      } else {
        ToastService.error(context, message);
      }
    });

    return AuthLayout(
      maxCardWidth: context.registerMaxContentWidth,
      contentAlignment: Alignment.topCenter,
      contentPadding: context.registerContentPadding,
      fillViewport: true,
      child: RegisterFormCard(
        onSignInTap: () => context.go(AppRoutes.authLogin),
      ),
    );
  }
}
