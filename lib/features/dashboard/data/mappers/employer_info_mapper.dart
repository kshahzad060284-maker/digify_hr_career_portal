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
      logoUrl: dto.logoUrl,
      logoAvailable: dto.logoAvailable,
      information: dto.information ?? dto.employeeInfo,
      industry: dto.industry,
      about: dto.aboutCompany,
    );
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
