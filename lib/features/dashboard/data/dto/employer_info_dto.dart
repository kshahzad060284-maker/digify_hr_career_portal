class EmployerInfoDto {
  const EmployerInfoDto({
    this.postingGuid,
    this.companyName,
    this.companyNameAr,
    this.employeeInfo,
    this.information,
    this.industry,
    this.aboutCompany,
    this.logoAvailable,
    this.logoUrl,
  });

  final String? postingGuid;
  final String? companyName;
  final String? companyNameAr;
  final String? employeeInfo;
  final String? information;
  final String? industry;
  final String? aboutCompany;
  final String? logoAvailable;
  final String? logoUrl;

  factory EmployerInfoDto.fromJson(Map<String, dynamic> json) {
    return EmployerInfoDto(
      postingGuid: json['posting_guid']?.toString(),
      companyName: json['company_name']?.toString(),
      companyNameAr: json['company_name_ar']?.toString(),
      employeeInfo: json['employee_info']?.toString(),
      information: json['information']?.toString(),
      industry: json['industry']?.toString(),
      aboutCompany: json['about_company']?.toString(),
      logoAvailable: json['logo_available']?.toString(),
      logoUrl: json['logo_url']?.toString(),
    );
  }
}

class EmployerInfoResponseDto {
  const EmployerInfoResponseDto({
    required this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String? message;
  final EmployerInfoDto? data;

  factory EmployerInfoResponseDto.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    EmployerInfoDto? data;
    if (rawData is Map<String, dynamic>) {
      data = EmployerInfoDto.fromJson(rawData);
    } else if (rawData is Map) {
      data = EmployerInfoDto.fromJson(
        rawData.map((key, value) => MapEntry(key.toString(), value)),
      );
    }

    return EmployerInfoResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      data: data,
    );
  }
}
