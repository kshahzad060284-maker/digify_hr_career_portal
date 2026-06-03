import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/utils/phone_number_utils.dart';
import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';

class RegisterState {
  const RegisterState({
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.email = '',
    this.phoneDialCode = PhoneNumberUtils.defaultDialCode,
    this.phone = '',
    this.currentCompany = '',
    this.currentTitle = '',
    this.totalExperience = '',
    this.currentLocation = '',
    this.willingToRelocate = RegisterRelocatePreference.no,
    this.currentSalary = '',
    this.expectedSalary = '',
    this.linkedIn = '',
    this.github = '',
    this.portfolio = '',
    this.password = '',
    this.confirmPassword = '',
    this.educationEntries = const [],
    this.workExperienceEntries = const [],
    this.isLoading = false,
    this.toastType,
    this.toastEventId = 0,
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneDialCode;
  final String phone;
  final String currentCompany;
  final String currentTitle;
  final String totalExperience;
  final String currentLocation;
  final RegisterRelocatePreference willingToRelocate;
  final String currentSalary;
  final String expectedSalary;
  final String linkedIn;
  final String github;
  final String portfolio;
  final String password;
  final String confirmPassword;
  final List<RegisterEducationEntry> educationEntries;
  final List<RegisterWorkExperienceEntry> workExperienceEntries;
  final bool isLoading;
  final RegisterToastType? toastType;
  final int toastEventId;

  bool get canSubmit => !isLoading;

  RegisterState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneDialCode,
    String? phone,
    String? currentCompany,
    String? currentTitle,
    String? totalExperience,
    String? currentLocation,
    RegisterRelocatePreference? willingToRelocate,
    String? currentSalary,
    String? expectedSalary,
    String? linkedIn,
    String? github,
    String? portfolio,
    String? password,
    String? confirmPassword,
    List<RegisterEducationEntry>? educationEntries,
    List<RegisterWorkExperienceEntry>? workExperienceEntries,
    bool? isLoading,
    RegisterToastType? toastType,
    int? toastEventId,
    bool clearToast = false,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneDialCode: phoneDialCode ?? this.phoneDialCode,
      phone: phone ?? this.phone,
      currentCompany: currentCompany ?? this.currentCompany,
      currentTitle: currentTitle ?? this.currentTitle,
      totalExperience: totalExperience ?? this.totalExperience,
      currentLocation: currentLocation ?? this.currentLocation,
      willingToRelocate: willingToRelocate ?? this.willingToRelocate,
      currentSalary: currentSalary ?? this.currentSalary,
      expectedSalary: expectedSalary ?? this.expectedSalary,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      educationEntries: educationEntries ?? this.educationEntries,
      workExperienceEntries:
          workExperienceEntries ?? this.workExperienceEntries,
      isLoading: isLoading ?? this.isLoading,
      toastType: clearToast ? null : (toastType ?? this.toastType),
      toastEventId: toastEventId ?? this.toastEventId,
    );
  }
}
