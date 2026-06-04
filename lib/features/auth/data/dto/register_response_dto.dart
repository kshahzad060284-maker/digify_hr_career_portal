class RegisterResponseDto {
  const RegisterResponseDto({
    required this.success,
    this.message,
    this.candidateId,
    this.candidateGuid,
    this.candidateUserId,
    this.candidateUserGuid,
  });

  final bool success;
  final String? message;
  final int? candidateId;
  final String? candidateGuid;
  final int? candidateUserId;
  final String? candidateUserGuid;

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      candidateId: _parseInt(json['candidate_id']),
      candidateGuid: json['candidate_guid']?.toString(),
      candidateUserId: _parseInt(json['candidate_user_id']),
      candidateUserGuid: json['candidate_user_guid']?.toString(),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }
}
