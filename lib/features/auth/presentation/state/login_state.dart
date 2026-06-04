import 'package:career_portal/core/common/auth_enums.dart';

class LoginState {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.toastType,
    this.toastEventId = 0,
    this.signInSuccessEventId = 0,
    this.signInFailureMessage,
  });

  final String email;
  final String password;
  final bool isLoading;
  final LoginToastType? toastType;
  final int toastEventId;
  final int signInSuccessEventId;
  final String? signInFailureMessage;

  bool get canSubmit => !isLoading;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    LoginToastType? toastType,
    int? toastEventId,
    int? signInSuccessEventId,
    String? signInFailureMessage,
    bool clearToast = false,
    bool clearCredentials = false,
    bool clearSignInFailureMessage = false,
  }) {
    return LoginState(
      email: clearCredentials ? '' : (email ?? this.email),
      password: clearCredentials ? '' : (password ?? this.password),
      isLoading: isLoading ?? this.isLoading,
      toastType: clearToast ? null : (toastType ?? this.toastType),
      toastEventId: toastEventId ?? this.toastEventId,
      signInSuccessEventId: signInSuccessEventId ?? this.signInSuccessEventId,
      signInFailureMessage: clearSignInFailureMessage
          ? null
          : (signInFailureMessage ?? this.signInFailureMessage),
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
          toastEventId == other.toastEventId &&
          signInSuccessEventId == other.signInSuccessEventId &&
          signInFailureMessage == other.signInFailureMessage;

  @override
  int get hashCode => Object.hash(
    email,
    password,
    isLoading,
    toastType,
    toastEventId,
    signInSuccessEventId,
    signInFailureMessage,
  );
}
