class EmployerInfoDto {
  const EmployerInfoDto({
    this.employerInfoId,
    this.employerInfoGuid,
    this.enterpriseId,
    this.assignmentType,
    this.companyId,
    this.companyCode,
    this.companyName,
    this.companyNameAr,
    this.employeeInfo,
    this.information,
    this.industry,
    this.aboutCompany,
    this.logoAvailable,
    this.logoFileName,
    this.logoMimeType,
    this.logoUrl,
    this.activeFlag,
  });

  final int? employerInfoId;
  final String? employerInfoGuid;
  final int? enterpriseId;
  final String? assignmentType;
  final String? companyId;
  final String? companyCode;
  final String? companyName;
  final String? companyNameAr;
  final String? employeeInfo;
  final String? information;
  final String? industry;
  final String? aboutCompany;
  final String? logoAvailable;
  final String? logoFileName;
  final String? logoMimeType;
  final String? logoUrl;
  final String? activeFlag;

  factory EmployerInfoDto.fromJson(Map<String, dynamic> json) {
    return EmployerInfoDto(
      employerInfoId: _asInt(json['employer_info_id']),
      employerInfoGuid: json['employer_info_guid']?.toString(),
      enterpriseId: _asInt(json['enterprise_id']),
      assignmentType:
          json['assignment_type']?.toString() ??
          json['employer_info_source']?.toString(),
      companyId: json['company_id']?.toString(),
      companyCode: json['company_code']?.toString(),
      companyName: json['company_name']?.toString(),
      companyNameAr: json['company_name_ar']?.toString(),
      employeeInfo: json['employee_info']?.toString(),
      information: json['information']?.toString(),
      industry: json['industry']?.toString(),
      aboutCompany: json['about_company']?.toString(),
      logoAvailable: json['logo_available']?.toString(),
      logoFileName: json['logo_file_name']?.toString(),
      logoMimeType: json['logo_mime_type']?.toString(),
      logoUrl: json['logo_url']?.toString(),
      activeFlag: json['active_flag']?.toString(),
    );
  }

  static int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}

class EmployerInfoResponseDto {
  const EmployerInfoResponseDto({
    required this.success,
    this.message,
    this.data = const <EmployerInfoDto>[],
  });

  final bool success;
  final String? message;
  final List<EmployerInfoDto> data;

  factory EmployerInfoResponseDto.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final items = <EmployerInfoDto>[];

    if (rawData is List) {
      for (final item in rawData) {
        if (item is Map<String, dynamic>) {
          items.add(EmployerInfoDto.fromJson(item));
        } else if (item is Map) {
          items.add(
            EmployerInfoDto.fromJson(
              item.map((key, value) => MapEntry(key.toString(), value)),
            ),
          );
        }
      }
    } else if (rawData is Map<String, dynamic>) {
      items.add(EmployerInfoDto.fromJson(rawData));
    } else if (rawData is Map) {
      items.add(
        EmployerInfoDto.fromJson(
          rawData.map((key, value) => MapEntry(key.toString(), value)),
        ),
      );
    }

    return EmployerInfoResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      data: items,
    );
  }
}
