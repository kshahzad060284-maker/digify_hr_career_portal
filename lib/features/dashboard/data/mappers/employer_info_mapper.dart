import 'package:career_portal/features/dashboard/data/dto/employer_info_dto.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';

class EmployerInfoMapper {
  const EmployerInfoMapper._();

  static JobCompanyInfo toDomain(EmployerInfoDto dto) {
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
}
