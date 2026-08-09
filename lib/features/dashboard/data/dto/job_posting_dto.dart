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
    this.applicationStatus,
    this.appliedFlag,
    this.applicationId,
    this.applicationGuid,
    this.companyName,
    this.companyLogoUrl,
    this.companyInformation,
    this.companyIndustry,
    this.aboutTheCompany,
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
  final String? applicationStatus;
  final String? appliedFlag;
  final int? applicationId;
  final String? applicationGuid;
  final String? companyName;
  final String? companyLogoUrl;
  final String? companyInformation;
  final String? companyIndustry;
  final String? aboutTheCompany;

  factory JobPostingDto.fromJson(Map<String, dynamic> json) {
    final company = _asMap(json['company']);

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
      applicationStatus: json['application_status']?.toString(),
      appliedFlag: json['applied_flag']?.toString(),
      applicationId: _asNullableInt(json['application_id']),
      applicationGuid: json['application_guid']?.toString(),
      companyName: _firstNonEmpty([
        json['company_name'],
        company?['company_name'],
        company?['name'],
      ]),
      companyLogoUrl: _firstNonEmpty([
        json['company_logo'],
        json['company_logo_url'],
        json['logo_url'],
        company?['logo'],
        company?['logo_url'],
        company?['company_logo'],
      ]),
      companyInformation: _firstNonEmpty([
        json['company_information'],
        json['company_info'],
        company?['information'],
        company?['info'],
        company?['company_information'],
      ]),
      companyIndustry: _firstNonEmpty([
        json['company_industry'],
        json['industry'],
        company?['industry'],
        company?['company_industry'],
      ]),
      aboutTheCompany: _firstNonEmpty([
        json['about_the_company'],
        json['company_about'],
        json['company_description'],
        company?['about'],
        company?['about_the_company'],
        company?['description'],
      ]),
    );
  }
}

List<String> _asStringList(dynamic value) {
  if (value is! List) return const [];
  return value.map((item) => item.toString()).toList();
}

Map<String, dynamic>? _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, item) => MapEntry(key.toString(), item));
  }
  return null;
}

String? _firstNonEmpty(List<dynamic> values) {
  for (final value in values) {
    final text = value?.toString().trim();
    if (text != null && text.isNotEmpty) return text;
  }
  return null;
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

int? _asNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}
