import 'package:career_portal/core/common/auth_enums.dart';

class ForgotPasswordState {
  const ForgotPasswordState({
    this.step = ForgotPasswordStep.verifyEmail,
    this.email = '',
    this.otp = '',
    this.password = '',
    this.confirmPassword = '',
    this.resetToken = '',
    this.isLoading = false,
    this.toastMessage,
    this.toastIsSuccess = false,
    this.toastEventId = 0,
    this.loginNavEventId = 0,
    this.resendCooldownSeconds = 0,
  });

  final ForgotPasswordStep step;
  final String email;
  final String otp;
  final String password;
  final String confirmPassword;
  final String resetToken;
  final bool isLoading;
  final String? toastMessage;
  final bool toastIsSuccess;
  final int toastEventId;
  final int loginNavEventId;
  final int resendCooldownSeconds;

  bool get canSubmit => !isLoading;
  bool get canResendOtp => !isLoading && resendCooldownSeconds <= 0;

  ForgotPasswordState copyWith({
    ForgotPasswordStep? step,
    String? email,
    String? otp,
    String? password,
    String? confirmPassword,
    String? resetToken,
    bool? isLoading,
    String? toastMessage,
    bool? toastIsSuccess,
    int? toastEventId,
    int? loginNavEventId,
    int? resendCooldownSeconds,
    bool clearToast = false,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      resetToken: resetToken ?? this.resetToken,
      isLoading: isLoading ?? this.isLoading,
      toastMessage: clearToast ? null : (toastMessage ?? this.toastMessage),
      toastIsSuccess: toastIsSuccess ?? this.toastIsSuccess,
      toastEventId: toastEventId ?? this.toastEventId,
      loginNavEventId: loginNavEventId ?? this.loginNavEventId,
      resendCooldownSeconds:
          resendCooldownSeconds ?? this.resendCooldownSeconds,
    );
  }
}
