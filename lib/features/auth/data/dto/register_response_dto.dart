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
    final payload = _readPayload(json);

    return RegisterResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      candidateId: _parseInt(payload['candidate_id']),
      candidateGuid: payload['candidate_guid']?.toString(),
      candidateUserId: _parseInt(payload['candidate_user_id']),
      candidateUserGuid: payload['candidate_user_guid']?.toString(),
    );
  }

  static Map<String, dynamic> _readPayload(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return data;
    return json;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }
}
