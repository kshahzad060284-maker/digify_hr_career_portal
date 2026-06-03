import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/features/auth/presentation/state/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends Notifier<LoginState> {
  static final _emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  LoginState build() => const LoginState();

  void onEmailChanged(String value) {
    state = state.copyWith(email: value, clearToast: true);
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: value, clearToast: true);
  }

  void _emitToast(LoginToastType type) {
    state = state.copyWith(
      toastType: type,
      toastEventId: state.toastEventId + 1,
    );
  }

  LoginToastType? _validateEmail(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return LoginToastType.emailRequired;
    }
    if (!_emailPattern.hasMatch(trimmed)) {
      return LoginToastType.emailInvalid;
    }
    return null;
  }

  LoginToastType? _validatePassword(String value) {
    if (value.isEmpty) {
      return LoginToastType.passwordRequired;
    }
    return null;
  }

  bool validateForm() {
    final emailToast = _validateEmail(state.email);
    if (emailToast != null) {
      _emitToast(emailToast);
      return false;
    }
    final passwordToast = _validatePassword(state.password);
    if (passwordToast != null) {
      _emitToast(passwordToast);
      return false;
    }
    return true;
  }

  Future<void> signIn() async {
    if (state.isLoading) return;
    if (!validateForm()) return;

    state = state.copyWith(isLoading: true, clearToast: true);
    try {
      await Future<void>.delayed(const Duration(milliseconds: 400));
    } catch (_) {
      state = state.copyWith(isLoading: false);
      _emitToast(LoginToastType.signInFailed);
      return;
    }
    state = state.copyWith(isLoading: false);
  }

  void reset() {
    state = const LoginState();
  }
}
