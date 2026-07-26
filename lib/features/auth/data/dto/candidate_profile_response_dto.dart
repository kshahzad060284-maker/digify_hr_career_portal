class CandidateProfileResponseDto {
  const CandidateProfileResponseDto({required this.success, this.data});

  final bool success;
  final CandidateProfileDto? data;

  factory CandidateProfileResponseDto.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return CandidateProfileResponseDto(
      success: json['success'] == true,
      data: rawData is Map<String, dynamic>
          ? CandidateProfileDto.fromJson(rawData)
          : null,
    );
  }
}

class CandidateProfileDto {
  const CandidateProfileDto({
    required this.candidateId,
    required this.candidateGuid,
    required this.fullName,
    required this.email,
    required this.status,
  });

  final int candidateId;
  final String candidateGuid;
  final String fullName;
  final String email;
  final String status;

  factory CandidateProfileDto.fromJson(Map<String, dynamic> json) {
    return CandidateProfileDto(
      candidateId: _parseInt(json['candidate_id']),
      candidateGuid: json['candidate_guid']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
