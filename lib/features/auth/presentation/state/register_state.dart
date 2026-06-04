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
    this.source = '',
    this.noticePeriod = '',
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
    this.registerSuccessEventId = 0,
    this.registerFailureMessage,
    this.registerSuccessMessage,
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
  final String source;
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
  final List<RegisterWorkExperienceEntry> workExperienceEntries;
  final bool isLoading;
  final RegisterToastType? toastType;
  final int toastEventId;
  final int registerSuccessEventId;
  final String? registerFailureMessage;
  final String? registerSuccessMessage;

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
    String? source,
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
    List<RegisterWorkExperienceEntry>? workExperienceEntries,
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
      firstName: clearForm ? '' : (firstName ?? this.firstName),
      middleName: clearForm ? '' : (middleName ?? this.middleName),
      lastName: clearForm ? '' : (lastName ?? this.lastName),
      email: clearForm ? '' : (email ?? this.email),
      phoneDialCode: clearForm
          ? PhoneNumberUtils.defaultDialCode
          : (phoneDialCode ?? this.phoneDialCode),
      phone: clearForm ? '' : (phone ?? this.phone),
      currentCompany: clearForm ? '' : (currentCompany ?? this.currentCompany),
      currentTitle: clearForm ? '' : (currentTitle ?? this.currentTitle),
      totalExperience: clearForm
          ? ''
          : (totalExperience ?? this.totalExperience),
      currentLocation: clearForm
          ? ''
          : (currentLocation ?? this.currentLocation),
      source: clearForm ? '' : (source ?? this.source),
      noticePeriod: clearForm ? '' : (noticePeriod ?? this.noticePeriod),
      willingToRelocate: clearForm
          ? RegisterRelocatePreference.no
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
      workExperienceEntries: clearForm
          ? const []
          : (workExperienceEntries ?? this.workExperienceEntries),
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
