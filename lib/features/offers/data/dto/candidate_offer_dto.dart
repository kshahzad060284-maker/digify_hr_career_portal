class CandidateOfferDto {
  const CandidateOfferDto({
    required this.offerGuid,
    required this.offerNumber,
    required this.jobTitle,
    required this.location,
    required this.workModeCode,
    required this.employmentTypeCode,
    required this.startDate,
    required this.offerDate,
    required this.expiryDate,
    required this.stage,
    required this.statusCode,
    required this.stageDescription,
    this.annualSalary,
    this.componentAmount,
    this.postingTitle = '',
    this.departmentName = '',
    this.currencyCode = '',
    this.frequencyCode = '',
  });

  final String offerGuid;
  final String offerNumber;
  final String jobTitle;
  final String location;
  final String workModeCode;
  final String employmentTypeCode;
  final String startDate;
  final String offerDate;
  final String expiryDate;
  final String stage;
  final String statusCode;
  final String stageDescription;
  final double? annualSalary;
  final double? componentAmount;
  final String postingTitle;
  final String departmentName;
  final String currencyCode;
  final String frequencyCode;

  factory CandidateOfferDto.fromJson(Map<String, dynamic> json) {
    final postingObj = json['posting_obj'];
    final departmentObj = json['department_obj'];
    final components = json['components_json'];
    final firstComponent = _firstComponent(components);

    return CandidateOfferDto(
      offerGuid: json['offer_guid']?.toString() ?? '',
      offerNumber: json['offer_number']?.toString() ?? '',
      jobTitle: json['job_title']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      workModeCode: json['work_mode_code']?.toString() ?? '',
      employmentTypeCode: json['employment_type_code']?.toString() ?? '',
      startDate: json['start_date']?.toString() ?? '',
      offerDate: json['offer_date']?.toString() ?? '',
      expiryDate: json['expiry_date']?.toString() ?? '',
      stage: json['stage']?.toString() ?? '',
      statusCode: json['status_code']?.toString() ?? '',
      stageDescription: json['stage_description']?.toString() ?? '',
      annualSalary: _asDouble(json['annual_salary']),
      componentAmount: _asDouble(firstComponent?['amount']),
      postingTitle: postingObj is Map<String, dynamic>
          ? postingObj['posting_title']?.toString() ?? ''
          : '',
      departmentName: departmentObj is Map<String, dynamic>
          ? departmentObj['org_unit_name']?.toString() ?? ''
          : '',
      currencyCode: firstComponent?['currency_code']?.toString() ?? '',
      frequencyCode: firstComponent?['frequency_code']?.toString() ?? '',
    );
  }
}

double? _asDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

Map<String, dynamic>? _firstComponent(dynamic components) {
  if (components is! List || components.isEmpty) return null;
  final first = components.first;
  if (first is Map<String, dynamic>) return first;
  return null;
}
