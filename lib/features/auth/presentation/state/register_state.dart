import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/utils/email_utils.dart';
import 'package:career_portal/core/utils/phone_number_utils.dart';
import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_skill_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';

class RegisterState {
  const RegisterState({
    this.step = RegisterStep.personalInfo,
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.email = '',
    this.phoneDialCode = PhoneNumberUtils.defaultDialCode,
    this.phone = '',
    this.dateOfBirth,
    this.gender,
    this.nationality = '',
    this.alternatePhoneDialCode = PhoneNumberUtils.defaultDialCode,
    this.alternatePhone = '',
    this.alternateEmail = '',
    this.currentCompany = '',
    this.currentTitle = '',
    this.totalExperience = '',
    this.currentLocation = '',
    this.preferredLocation = '',
    this.source = '',
    this.visaStatus,
    this.noticePeriod = '',
    this.willingToRelocate = RegisterRelocatePreference.yes,
    this.currentSalary = '',
    this.expectedSalary = '',
    this.linkedIn = '',
    this.github = '',
    this.portfolio = '',
    this.password = '',
    this.confirmPassword = '',
    this.educationEntries = const [],
    this.experienceType = RegisterExperienceType.fresh,
    this.workExperienceEntries = const [],
    this.skills = const [],
    this.isLoading = false,
    this.toastType,
    this.toastEventId = 0,
    this.registerSuccessEventId = 0,
    this.registerFailureMessage,
    this.registerSuccessMessage,
  });

  final RegisterStep step;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneDialCode;
  final String phone;
  final DateTime? dateOfBirth;
  final RegisterGender? gender;
  final String nationality;
  final String alternatePhoneDialCode;
  final String alternatePhone;
  final String alternateEmail;
  final String currentCompany;
  final String currentTitle;
  final String totalExperience;
  final String currentLocation;
  final String preferredLocation;
  final String source;
  final RegisterVisaStatus? visaStatus;
  final String noticePeriod;
  final RegisterRelocatePreference willingToRelocate;
  final String currentSalary;
  final String expectedSalary;
  final String linkedIn;
  final String github;
  final String portfolio;
  final String password;
  final String confirmPassword;
  final List<RegisterEducationEntry> educationEntries;
  final RegisterExperienceType experienceType;
  final List<RegisterWorkExperienceEntry> workExperienceEntries;
  final List<RegisterSkillEntry> skills;
  final bool isLoading;
  final RegisterToastType? toastType;
  final int toastEventId;
  final int registerSuccessEventId;
  final String? registerFailureMessage;
  final String? registerSuccessMessage;

  bool get canSubmit => !isLoading;

  bool containsSkill(String value) {
    final name = value.trim().toLowerCase();
    if (name.isEmpty) return false;
    return skills.any((skill) => skill.skillName.trim().toLowerCase() == name);
  }

  bool isStepValid(RegisterStep step) => validationErrorFor(step) == null;

  RegisterToastType? validationErrorFor(RegisterStep step) {
    return switch (step) {
      RegisterStep.personalInfo => _personalInfoError,
      RegisterStep.professionalInfo => _professionalInfoError,
      RegisterStep.socialLinks => null,
      RegisterStep.education =>
        educationEntries.isEmpty ? RegisterToastType.educationRequired : null,
      RegisterStep.workExperience => _workExperienceError,
      RegisterStep.security => _securityError,
    };
  }

  RegisterToastType? get _personalInfoError {
    if (firstName.trim().isEmpty) return RegisterToastType.firstNameRequired;
    if (lastName.trim().isEmpty) return RegisterToastType.lastNameRequired;
    if (EmailUtils.isEmpty(email)) return RegisterToastType.emailRequired;
    if (!EmailUtils.isValid(email)) return RegisterToastType.emailInvalid;
    if (!EmailUtils.isEmpty(alternateEmail) &&
        !EmailUtils.isValid(alternateEmail)) {
      return RegisterToastType.emailInvalid;
    }
    if (phone.trim().isEmpty) return RegisterToastType.phoneRequired;
    if (dateOfBirth == null) return RegisterToastType.dateOfBirthRequired;
    if (nationality.trim().isEmpty) {
      return RegisterToastType.nationalityRequired;
    }
    return null;
  }

  RegisterToastType? get _professionalInfoError {
    if (currentLocation.trim().isEmpty) {
      return RegisterToastType.currentLocationRequired;
    }
    return null;
  }

  RegisterToastType? get _workExperienceError {
    if (experienceType == RegisterExperienceType.experienced &&
        workExperienceEntries.isEmpty) {
      return RegisterToastType.workExperienceRequired;
    }
    if (skills.isEmpty) return RegisterToastType.skillsRequired;
    return null;
  }

  RegisterToastType? get _securityError {
    if (password.isEmpty) return RegisterToastType.passwordRequired;
    if (confirmPassword.isEmpty) {
      return RegisterToastType.confirmPasswordRequired;
    }
    if (password != confirmPassword) {
      return RegisterToastType.passwordsMismatch;
    }
    return null;
  }

  RegisterState copyWith({
    RegisterStep? step,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneDialCode,
    String? phone,
    DateTime? dateOfBirth,
    RegisterGender? gender,
    String? nationality,
    String? alternatePhoneDialCode,
    String? alternatePhone,
    String? alternateEmail,
    String? currentCompany,
    String? currentTitle,
    String? totalExperience,
    String? currentLocation,
    String? preferredLocation,
    String? source,
    RegisterVisaStatus? visaStatus,
    String? noticePeriod,
    RegisterRelocatePreference? willingToRelocate,
    String? currentSalary,
    String? expectedSalary,
    String? linkedIn,
    String? github,
    String? portfolio,
    String? password,
    String? confirmPassword,
    List<RegisterEducationEntry>? educationEntries,
    RegisterExperienceType? experienceType,
    List<RegisterWorkExperienceEntry>? workExperienceEntries,
    List<RegisterSkillEntry>? skills,
    bool? isLoading,
    RegisterToastType? toastType,
    int? toastEventId,
    int? registerSuccessEventId,
    String? registerFailureMessage,
    String? registerSuccessMessage,
    bool clearToast = false,
    bool clearRegisterFailureMessage = false,
    bool clearRegisterSuccessMessage = false,
    bool clearForm = false,
  }) {
    return RegisterState(
      step: clearForm ? RegisterStep.personalInfo : (step ?? this.step),
      firstName: clearForm ? '' : (firstName ?? this.firstName),
      middleName: clearForm ? '' : (middleName ?? this.middleName),
      lastName: clearForm ? '' : (lastName ?? this.lastName),
      email: clearForm ? '' : (email ?? this.email),
      phoneDialCode: clearForm
          ? PhoneNumberUtils.defaultDialCode
          : (phoneDialCode ?? this.phoneDialCode),
      phone: clearForm ? '' : (phone ?? this.phone),
      dateOfBirth: clearForm ? null : (dateOfBirth ?? this.dateOfBirth),
      gender: clearForm ? null : (gender ?? this.gender),
      nationality: clearForm ? '' : (nationality ?? this.nationality),
      alternatePhoneDialCode: clearForm
          ? PhoneNumberUtils.defaultDialCode
          : (alternatePhoneDialCode ?? this.alternatePhoneDialCode),
      alternatePhone: clearForm ? '' : (alternatePhone ?? this.alternatePhone),
      alternateEmail: clearForm ? '' : (alternateEmail ?? this.alternateEmail),
      currentCompany: clearForm ? '' : (currentCompany ?? this.currentCompany),
      currentTitle: clearForm ? '' : (currentTitle ?? this.currentTitle),
      totalExperience: clearForm
          ? ''
          : (totalExperience ?? this.totalExperience),
      currentLocation: clearForm
          ? ''
          : (currentLocation ?? this.currentLocation),
      preferredLocation: clearForm
          ? ''
          : (preferredLocation ?? this.preferredLocation),
      source: clearForm ? '' : (source ?? this.source),
      visaStatus: clearForm ? null : (visaStatus ?? this.visaStatus),
      noticePeriod: clearForm ? '' : (noticePeriod ?? this.noticePeriod),
      willingToRelocate: clearForm
          ? RegisterRelocatePreference.yes
          : (willingToRelocate ?? this.willingToRelocate),
      currentSalary: clearForm ? '' : (currentSalary ?? this.currentSalary),
      expectedSalary: clearForm ? '' : (expectedSalary ?? this.expectedSalary),
      linkedIn: clearForm ? '' : (linkedIn ?? this.linkedIn),
      github: clearForm ? '' : (github ?? this.github),
      portfolio: clearForm ? '' : (portfolio ?? this.portfolio),
      password: clearForm ? '' : (password ?? this.password),
      confirmPassword: clearForm
          ? ''
          : (confirmPassword ?? this.confirmPassword),
      educationEntries: clearForm
          ? const []
          : (educationEntries ?? this.educationEntries),
      experienceType: clearForm
          ? RegisterExperienceType.fresh
          : (experienceType ?? this.experienceType),
      workExperienceEntries: clearForm
          ? const []
          : (workExperienceEntries ?? this.workExperienceEntries),
      skills: clearForm ? const [] : (skills ?? this.skills),
      isLoading: isLoading ?? this.isLoading,
      toastType: clearToast ? null : (toastType ?? this.toastType),
      toastEventId: toastEventId ?? this.toastEventId,
      registerSuccessEventId:
          registerSuccessEventId ?? this.registerSuccessEventId,
      registerFailureMessage: clearRegisterFailureMessage
          ? null
          : (registerFailureMessage ?? this.registerFailureMessage),
      registerSuccessMessage: clearRegisterSuccessMessage
          ? null
          : (registerSuccessMessage ?? this.registerSuccessMessage),
    );
  }
}
