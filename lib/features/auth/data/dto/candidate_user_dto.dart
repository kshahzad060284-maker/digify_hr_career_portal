class CandidateUserDto {
  const CandidateUserDto({
    required this.candidateUserId,
    required this.candidateUserGuid,
    required this.candidateId,
    required this.candidateGuid,
    required this.fullName,
    required this.email,
    required this.userStatus,
  });

  final int candidateUserId;
  final String candidateUserGuid;
  final int candidateId;
  final String candidateGuid;
  final String fullName;
  final String email;
  final String userStatus;

  factory CandidateUserDto.fromJson(Map<String, dynamic> json) {
    return CandidateUserDto(
      candidateUserId: _parseInt(json['candidate_user_id']),
      candidateUserGuid: json['candidate_user_guid']?.toString() ?? '',
      candidateId: _parseInt(json['candidate_id']),
      candidateGuid: json['candidate_guid']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      userStatus: json['user_status']?.toString() ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
