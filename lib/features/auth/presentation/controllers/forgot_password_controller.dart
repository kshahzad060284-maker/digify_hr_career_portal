import 'dart:async';

import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/utils/email_utils.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:career_portal/features/auth/presentation/state/forgot_password_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordController
    extends AutoDisposeNotifier<ForgotPasswordState> {
  static const _otpLength = 6;
  static const _resendCooldown = 120;

  Timer? _resendTimer;

  @override
  ForgotPasswordState build() {
    ref.onDispose(() => _resendTimer?.cancel());
    return const ForgotPasswordState();
  }

  void onEmailChanged(String value) {
    state = state.copyWith(email: value, clearToast: true);
  }

  void onOtpChanged(String value) {
    state = state.copyWith(otp: value, clearToast: true);
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: value, clearToast: true);
  }

  void onConfirmPasswordChanged(String value) {
    state = state.copyWith(confirmPassword: value, clearToast: true);
  }

  void goToStep(ForgotPasswordStep step) {
    if (step.index > state.step.index) return;
    state = state.copyWith(step: step, clearToast: true);
  }

  void _emitToast(String message, {required bool isSuccess}) {
    final trimmed = message.trim();
    if (trimmed.isEmpty) return;

    state = state.copyWith(
      toastMessage: trimmed,
      toastIsSuccess: isSuccess,
      toastEventId: state.toastEventId + 1,
    );
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    state = state.copyWith(resendCooldownSeconds: _resendCooldown);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final next = state.resendCooldownSeconds - 1;
      if (next <= 0) {
        timer.cancel();
        state = state.copyWith(resendCooldownSeconds: 0);
        return;
      }
      state = state.copyWith(resendCooldownSeconds: next);
    });
  }

  Future<void> sendOtp(AppLocalizations l10n, {bool isResend = false}) async {
    if (state.isLoading) return;
    if (isResend && !state.canResendOtp) return;
    if (!EmailUtils.isValid(state.email)) {
      _emitToast(l10n.authEmailInvalid, isSuccess: false);
      return;
    }

    final email = EmailUtils.normalize(state.email);
    state = state.copyWith(isLoading: true, email: email, clearToast: true);

    try {
      final message = await ref
          .read(forgotPasswordUseCaseProvider)
          .call(enterpriseId: ref.read(enterpriseIdProvider), email: email);

      state = state.copyWith(
        isLoading: false,
        step: ForgotPasswordStep.checkOtp,
      );
      _startResendCooldown();
      _emitToast(message, isSuccess: true);
    } on AppException catch (error) {
      state = state.copyWith(isLoading: false);
      _emitToast(error.message, isSuccess: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resendOtp(AppLocalizations l10n) =>
      sendOtp(l10n, isResend: true);

  Future<void> verifyOtp(AppLocalizations l10n) async {
    if (state.isLoading) return;
    if (state.otp.length != _otpLength) {
      _emitToast(l10n.authOtpRequired, isSuccess: false);
      return;
    }

    state = state.copyWith(isLoading: true, clearToast: true);

    try {
      final result = await ref
          .read(verifyResetOtpUseCaseProvider)
          .call(
            enterpriseId: ref.read(enterpriseIdProvider),
            email: state.email,
            otp: state.otp,
          );

      state = state.copyWith(
        isLoading: false,
        resetToken: result.resetToken,
        step: ForgotPasswordStep.resetPassword,
      );
      _emitToast(result.message, isSuccess: true);
    } on AppException catch (error) {
      state = state.copyWith(isLoading: false);
      _emitToast(error.message, isSuccess: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resetPassword(AppLocalizations l10n) async {
    if (state.isLoading) return;
    if (state.password.isEmpty) {
      _emitToast(l10n.authPasswordRequired, isSuccess: false);
      return;
    }
    if (state.password != state.confirmPassword) {
      _emitToast(l10n.authPasswordsMismatch, isSuccess: false);
      return;
    }
    if (state.resetToken.isEmpty) {
      return;
    }

    state = state.copyWith(isLoading: true, clearToast: true);

    try {
      final message = await ref
          .read(resetPasswordUseCaseProvider)
          .call(
            resetToken: state.resetToken,
            newPassword: state.password,
            confirmPassword: state.confirmPassword,
          );

      final trimmed = message.trim();
      state = state.copyWith(
        isLoading: false,
        otp: '',
        password: '',
        confirmPassword: '',
        resetToken: '',
        toastMessage: trimmed.isEmpty ? null : trimmed,
        toastIsSuccess: true,
        toastEventId: trimmed.isEmpty
            ? state.toastEventId
            : state.toastEventId + 1,
        loginNavEventId: state.loginNavEventId + 1,
        clearToast: trimmed.isEmpty,
      );
    } on AppException catch (error) {
      state = state.copyWith(isLoading: false);
      _emitToast(error.message, isSuccess: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }
}
