import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/features/auth/presentation/layouts/auth_layout.dart';
import 'package:career_portal/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/forgot_password/forgot_password_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagePadding = context.pagePadding;

    ref.listen(forgotPasswordControllerProvider, (previous, next) {
      if (next.toastEventId != (previous?.toastEventId ?? 0) &&
          next.toastMessage != null) {
        if (next.toastIsSuccess) {
          ToastService.success(context, next.toastMessage!);
        } else {
          ToastService.error(context, next.toastMessage!);
        }
      }

      if (next.loginNavEventId != (previous?.loginNavEventId ?? 0)) {
        context.go(AppRoutes.authLogin);
      }
    });

    return AuthLayout(
      onBack: () => context.go(AppRoutes.authLogin),
      maxCardWidth: context.authMaxCardWidth,
      contentPadding: EdgeInsetsDirectional.symmetric(
        vertical: pagePadding.top,
      ),
      child: ForgotPasswordFormCard(
        onSignInTap: () => context.go(AppRoutes.authLogin),
      ),
    );
  }
}
