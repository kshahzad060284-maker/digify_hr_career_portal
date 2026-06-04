import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';

class RegisterCandidateInput {
  const RegisterCandidateInput({
    required this.enterpriseId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.source,
    required this.salaryCurrency,
    required this.createdBy,
    required this.password,
    this.middleName = '',
    this.currentTitle = '',
    this.currentEmployer = '',
    this.yearsExperience = 0,
    this.currentLocation = '',
    this.expectedSalary = '',
    this.noticePeriod = 0,
    this.linkedInProfile = '',
    this.githubLink = '',
    this.portfolioLink = '',
    this.willingToRelocate = false,
    this.educationEntries = const [],
    this.workExperienceEntries = const [],
  });

  final int enterpriseId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final String phone;
  final String currentTitle;
  final String currentEmployer;
  final int yearsExperience;
  final String currentLocation;
  final String source;
  final String expectedSalary;
  final String salaryCurrency;
  final int noticePeriod;
  final String linkedInProfile;
  final List<RegisterEducationEntry> educationEntries;
  final List<RegisterWorkExperienceEntry> workExperienceEntries;
  final String githubLink;
  final String portfolioLink;
  final bool willingToRelocate;
  final String createdBy;
  final String password;
}
