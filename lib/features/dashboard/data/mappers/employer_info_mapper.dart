import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/network/api_endpoints.dart';
import 'package:career_portal/features/dashboard/data/dto/employer_info_dto.dart';
import 'package:career_portal/features/dashboard/domain/models/employer_assignment_type.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';

class EmployerInfoMapper {
  const EmployerInfoMapper._();

  static JobCompanyInfo toDomain(
    List<EmployerInfoDto> items, {
    EmployerAssignmentType preferredType =
        EmployerAssignmentType.enterpriseLevel,
  }) {
    if (items.isEmpty) {
      throw StateError('Employer info list is empty.');
    }

    final preferred = _firstOfType(items, preferredType);
    final selected = preferred ?? items.first;
    return fromDto(selected);
  }

  static JobCompanyInfo fromDto(EmployerInfoDto dto) {
    return JobCompanyInfo.fromApi(
      name: dto.companyName ?? '',
      nameAr: dto.companyNameAr,
      logoUrl: _logoUrlOnApiHost(
        dto.employerInfoGuid ?? '',
        dto.logoAvailable,
        dto.logoUrl,
        dto.logoFileName,
      ),
      logoAvailable: dto.logoAvailable,
      logoMimeType: dto.logoMimeType,
      information: dto.information ?? dto.employeeInfo,
      industry: dto.industry,
      about: dto.aboutCompany,
    );
  }

  static String? _logoUrlOnApiHost(
    String guid,
    String? logoAvailable,
    String? fromApi,
    String? logoFileName,
  ) {
    final hasLogo = (logoAvailable ?? '').toUpperCase() == 'Y';
    if (!hasLogo || guid.isEmpty) return fromApi;

    final base = AppConfig.baseUrl.endsWith('/')
        ? AppConfig.baseUrl.substring(0, AppConfig.baseUrl.length - 1)
        : AppConfig.baseUrl;
    final v = (logoFileName?.trim() ?? '').hashCode;
    return '$base${RecEndpoints.employerInfoLogo(guid)}?v=$v';
  }

  static EmployerInfoDto? _firstOfType(
    List<EmployerInfoDto> items,
    EmployerAssignmentType type,
  ) {
    for (final item in items) {
      if (EmployerAssignmentType.tryParse(item.assignmentType) == type) {
        return item;
      }
    }
    return null;
  }
}
