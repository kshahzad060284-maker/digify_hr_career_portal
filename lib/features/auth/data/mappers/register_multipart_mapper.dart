import 'package:career_portal/features/auth/data/mappers/register_json_mapper.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:dio/dio.dart';

abstract final class RegisterMultipartMapper {
  RegisterMultipartMapper._();

  static FormData toFormData(RegisterCandidateInput input) {
    final fields = <String, dynamic>{
      'enterprise_id': input.enterpriseId,
      'first_name': input.firstName,
      'last_name': input.lastName,
      'middle_name': input.middleName,
      'email': input.email,
      'password': input.password,
      'phone': input.phone,
      'current_title': input.currentTitle,
      'current_employer': input.currentEmployer,
      'years_experience': input.yearsExperience,
      'current_location': input.currentLocation,
      'source': input.source,
      'expected_salary': input.expectedSalary,
      'salary_currency': input.salaryCurrency,
      'notice_period': input.noticePeriod,
      'linkedin_profile': input.linkedInProfile,
      'education_json': RegisterJsonMapper.educationJson(
        input.educationEntries,
      ),
      'experience_json': RegisterJsonMapper.experienceJson(
        input.workExperienceEntries,
      ),
      'github_link': input.githubLink,
      'portfolio_link': input.portfolioLink,
      'willing_to_relocate': input.willingToRelocate ? 'Y' : 'N',
      'created_by': input.createdBy,
    };

    return FormData.fromMap(fields);
  }
}
