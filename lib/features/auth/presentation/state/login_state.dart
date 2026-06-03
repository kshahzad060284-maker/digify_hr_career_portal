import 'package:career_portal/core/common/auth_enums.dart';

class LoginState {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.toastType,
    this.toastEventId = 0,
  });

  final String email;
  final String password;
  final bool isLoading;
  final LoginToastType? toastType;
  final int toastEventId;

  bool get canSubmit => !isLoading;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    LoginToastType? toastType,
    int? toastEventId,
    bool clearToast = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      toastType: clearToast ? null : (toastType ?? this.toastType),
      toastEventId: toastEventId ?? this.toastEventId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          email == other.email &&
          password == other.password &&
          isLoading == other.isLoading &&
          toastType == other.toastType &&
          toastEventId == other.toastEventId;

  @override
  int get hashCode =>
      Object.hash(email, password, isLoading, toastType, toastEventId);
}
