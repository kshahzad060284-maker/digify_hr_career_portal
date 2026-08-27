class ForgotPasswordResponseDto {
  const ForgotPasswordResponseDto({
    required this.success,
    this.message,
    this.resetToken,
  });

  final bool success;
  final String? message;
  final String? resetToken;

  factory ForgotPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    String? resetToken;
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      resetToken = data['reset_token']?.toString();
    }
    resetToken ??= json['reset_token']?.toString();

    return ForgotPasswordResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      resetToken: resetToken?.trim(),
    );
  }
}
