import 'package:career_portal/core/extensions/number_formatting_extensions.dart';
import 'package:career_portal/features/auth/data/mappers/register_json_mapper.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:dio/dio.dart';

abstract final class RegisterMultipartMapper {
  RegisterMultipartMapper._();

  static FormData toFormData(RegisterCandidateInput input) {
    return FormData.fromMap({
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
      'preferred_location': input.preferredLocation,
      'source_from': input.source,
      'current_salary': input.currentSalary.withoutCommas,
      'expected_salary': input.expectedSalary.withoutCommas,
      'salary_currency': input.salaryCurrency,
      'notice_period': input.noticePeriod,
      'linkedin_profile': input.linkedInProfile,
      'education_json': RegisterJsonMapper.educationJson(
        input.educationEntries,
      ),
      'experience_json': RegisterJsonMapper.experienceJson(
        input.workExperienceEntries,
      ),
      'skills': RegisterJsonMapper.skillsJson(input.skills),
      'github_link': input.githubLink,
      'portfolio_link': input.portfolioLink,
      'willing_to_relocate': input.willingToRelocate ? 'Y' : 'N',
      'created_by': input.createdBy,
      'nationality': input.nationality,
      'alternate_phone': input.alternatePhone,
      'alternate_email': input.alternateEmail,
      if (input.dateOfBirth != null)
        'dob': RegisterJsonMapper.formatDate(input.dateOfBirth!),
      if (input.gender != null) 'gender': input.gender!.apiValue,
      if (input.visaStatus != null) 'visa_status': input.visaStatus!.apiValue,
    });
  }
}
