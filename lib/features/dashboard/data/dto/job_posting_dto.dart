class JobPostingDto {
  const JobPostingDto({
    required this.postingId,
    required this.postingGuid,
    required this.postingTitle,
    required this.postingDescription,
    required this.aboutTheRole,
    required this.responsibilities,
    required this.qualifications,
    required this.positionName,
    required this.employmentTypeCode,
    required this.workModeCode,
    required this.priorityCode,
    required this.numberOfOpenings,
    required this.targetStartDate,
    required this.startDate,
  });

  final int postingId;
  final String postingGuid;
  final String postingTitle;
  final String postingDescription;
  final String aboutTheRole;
  final List<String> responsibilities;
  final List<String> qualifications;
  final String positionName;
  final String employmentTypeCode;
  final String workModeCode;
  final String priorityCode;
  final int numberOfOpenings;
  final String? targetStartDate;
  final String? startDate;

  factory JobPostingDto.fromJson(Map<String, dynamic> json) {
    return JobPostingDto(
      postingId: _asInt(json['posting_id']),
      postingGuid: json['posting_guid']?.toString() ?? '',
      postingTitle: json['posting_title']?.toString() ?? '',
      postingDescription: json['posting_description']?.toString() ?? '',
      aboutTheRole: json['about_the_role']?.toString() ?? '',
      responsibilities: _asStringList(json['responsibilities']),
      qualifications: _asStringList(json['qualifications']),
      positionName: json['position_name']?.toString() ?? '',
      employmentTypeCode: json['employment_type_code']?.toString() ?? '',
      workModeCode: json['work_mode_code']?.toString() ?? '',
      priorityCode: json['priority_code']?.toString() ?? '',
      numberOfOpenings: _asInt(json['number_of_openings'], fallback: 1),
      targetStartDate: json['target_start_date']?.toString(),
      startDate: json['start_date']?.toString(),
    );
  }
}

List<String> _asStringList(dynamic value) {
  if (value is! List) return const [];
  return value.map((item) => item.toString()).toList();
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}
