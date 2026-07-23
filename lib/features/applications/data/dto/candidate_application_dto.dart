class CandidateApplicationDto {
  const CandidateApplicationDto({
    required this.applicationId,
    required this.applicationGuid,
    required this.applicationNumber,
    required this.postingId,
    required this.postingGuid,
    required this.postingTitle,
    required this.requisitionTitle,
    required this.currentStageCode,
    required this.statusCode,
    required this.appliedDate,
    this.resumeFileName,
  });

  final int applicationId;
  final String applicationGuid;
  final String applicationNumber;
  final int postingId;
  final String postingGuid;
  final String postingTitle;
  final String requisitionTitle;
  final String currentStageCode;
  final String statusCode;
  final String? appliedDate;
  final String? resumeFileName;

  factory CandidateApplicationDto.fromJson(Map<String, dynamic> json) {
    return CandidateApplicationDto(
      applicationId: _asInt(json['application_id']),
      applicationGuid: json['application_guid']?.toString() ?? '',
      applicationNumber: json['application_number']?.toString() ?? '',
      postingId: _asInt(json['posting_id']),
      postingGuid: json['posting_guid']?.toString() ?? '',
      postingTitle: json['posting_title']?.toString() ?? '',
      requisitionTitle: json['requisition_title']?.toString() ?? '',
      currentStageCode: json['current_stage_code']?.toString() ?? '',
      statusCode: json['status_code']?.toString() ?? '',
      appliedDate: json['applied_date']?.toString(),
      resumeFileName: json['resume_file_name']?.toString(),
    );
  }
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}
