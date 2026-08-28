import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/utils/phone_number_utils.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_skill_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:career_portal/features/auth/presentation/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterController extends Notifier<RegisterState> {
  @override
  RegisterState build() => const RegisterState();

  void _emitToast(RegisterToastType type, {String? failureMessage}) {
    state = state.copyWith(
      toastType: type,
      toastEventId: state.toastEventId + 1,
      registerFailureMessage: failureMessage,
      clearRegisterFailureMessage: failureMessage == null,
    );
  }

  void onFirstNameChanged(String value) =>
      state = state.copyWith(firstName: value, clearToast: true);

  void onMiddleNameChanged(String value) =>
      state = state.copyWith(middleName: value, clearToast: true);

  void onLastNameChanged(String value) =>
      state = state.copyWith(lastName: value, clearToast: true);

  void onEmailChanged(String value) =>
      state = state.copyWith(email: value, clearToast: true);

  void onPhoneDialCodeChanged(String value) =>
      state = state.copyWith(phoneDialCode: value, clearToast: true);

  void onPhoneNumberChanged(String value) =>
      state = state.copyWith(phone: value, clearToast: true);

  void onDateOfBirthChanged(DateTime? value) =>
      state = state.copyWith(dateOfBirth: value, clearToast: true);

  void onGenderChanged(RegisterGender? value) =>
      state = state.copyWith(gender: value, clearToast: true);

  void onNationalityChanged(String value) =>
      state = state.copyWith(nationality: value, clearToast: true);

  void onAlternatePhoneDialCodeChanged(String value) =>
      state = state.copyWith(alternatePhoneDialCode: value, clearToast: true);

  void onAlternatePhoneNumberChanged(String value) =>
      state = state.copyWith(alternatePhone: value, clearToast: true);

  void onAlternateEmailChanged(String value) =>
      state = state.copyWith(alternateEmail: value, clearToast: true);

  void onCurrentCompanyChanged(String value) =>
      state = state.copyWith(currentCompany: value, clearToast: true);

  void onCurrentTitleChanged(String value) =>
      state = state.copyWith(currentTitle: value, clearToast: true);

  void onTotalExperienceChanged(String value) =>
      state = state.copyWith(totalExperience: value, clearToast: true);

  void onCurrentLocationChanged(String value) =>
      state = state.copyWith(currentLocation: value, clearToast: true);

  void onPreferredLocationChanged(String value) =>
      state = state.copyWith(preferredLocation: value, clearToast: true);

  void onSourceChanged(String value) =>
      state = state.copyWith(source: value, clearToast: true);

  void onVisaStatusChanged(RegisterVisaStatus? value) =>
      state = state.copyWith(visaStatus: value, clearToast: true);

  void onNoticePeriodChanged(String value) =>
      state = state.copyWith(noticePeriod: value, clearToast: true);

  void onWillingToRelocateChanged(RegisterRelocatePreference value) =>
      state = state.copyWith(willingToRelocate: value, clearToast: true);

  void onCurrentSalaryChanged(String value) =>
      state = state.copyWith(currentSalary: value, clearToast: true);

  void onExpectedSalaryChanged(String value) =>
      state = state.copyWith(expectedSalary: value, clearToast: true);

  void onLinkedInChanged(String value) =>
      state = state.copyWith(linkedIn: value, clearToast: true);

  void onGithubChanged(String value) =>
      state = state.copyWith(github: value, clearToast: true);

  void onPortfolioChanged(String value) =>
      state = state.copyWith(portfolio: value, clearToast: true);

  void onPasswordChanged(String value) =>
      state = state.copyWith(password: value, clearToast: true);

  void onConfirmPasswordChanged(String value) =>
      state = state.copyWith(confirmPassword: value, clearToast: true);

  void addEducation(RegisterEducationEntry entry) {
    state = state.copyWith(
      educationEntries: [...state.educationEntries, entry],
      clearToast: true,
    );
  }

  void updateEducation(RegisterEducationEntry entry) {
    state = state.copyWith(
      educationEntries: [
        for (final e in state.educationEntries)
          if (e.id == entry.id) entry else e,
      ],
      clearToast: true,
    );
  }

  void removeEducation(String id) {
    state = state.copyWith(
      educationEntries: [
        for (final e in state.educationEntries)
          if (e.id != id) e,
      ],
      clearToast: true,
    );
  }

  void onExperienceTypeChanged(RegisterExperienceType value) {
    state = state.copyWith(
      experienceType: value,
      workExperienceEntries: value == RegisterExperienceType.fresh
          ? const []
          : state.workExperienceEntries,
      clearToast: true,
    );
  }

  void addWorkExperience(RegisterWorkExperienceEntry entry) {
    state = state.copyWith(
      workExperienceEntries: [...state.workExperienceEntries, entry],
      clearToast: true,
    );
  }

  void updateWorkExperience(RegisterWorkExperienceEntry entry) {
    state = state.copyWith(
      workExperienceEntries: [
        for (final e in state.workExperienceEntries)
          if (e.id == entry.id) entry else e,
      ],
      clearToast: true,
    );
  }

  void removeWorkExperience(String id) {
    state = state.copyWith(
      workExperienceEntries: [
        for (final e in state.workExperienceEntries)
          if (e.id != id) e,
      ],
      clearToast: true,
    );
  }

  void addSkill(String value) {
    final skillName = value.trim();
    if (skillName.isEmpty) return;

    state = state.copyWith(
      skills: [
        ...state.skills,
        RegisterSkillEntry(skillName: skillName),
      ],
      clearToast: true,
    );
  }

  void removeSkill(String skillName) {
    state = state.copyWith(
      skills: [
        for (final skill in state.skills)
          if (skill.skillName != skillName) skill,
      ],
      clearToast: true,
    );
  }

  static const _steps = RegisterStep.values;

  RegisterStep? get _nextStep {
    final index = state.step.index;
    if (index >= _steps.length - 1) return null;
    return _steps[index + 1];
  }

  RegisterStep? get _previousStep {
    final index = state.step.index;
    if (index <= 0) return null;
    return _steps[index - 1];
  }

  void goToStep(RegisterStep step) {
    if (step.index > state.step.index) return;
    state = state.copyWith(step: step, clearToast: true);
  }

  void previousStep() {
    final previous = _previousStep;
    if (previous == null) return;
    state = state.copyWith(step: previous, clearToast: true);
  }

  void nextStep() {
    final next = _nextStep;
    if (next == null) return;
    state = state.copyWith(step: next, clearToast: true);
  }

  RegisterCandidateInput _buildInput() {
    return RegisterCandidateInput(
      enterpriseId: ref.read(enterpriseIdProvider),
      firstName: state.firstName,
      lastName: state.lastName,
      middleName: state.middleName,
      email: state.email,
      password: state.password,
      phone:
          PhoneNumberUtils.fullPhoneNumber(
            dialCode: state.phoneDialCode,
            localNumber: state.phone,
          ) ??
          '',
      dateOfBirth: state.dateOfBirth,
      gender: state.gender,
      nationality: state.nationality,
      alternatePhone:
          PhoneNumberUtils.fullPhoneNumber(
            dialCode: state.alternatePhoneDialCode,
            localNumber: state.alternatePhone,
          ) ??
          '',
      alternateEmail: state.alternateEmail,
      currentTitle: state.currentTitle,
      currentEmployer: state.currentCompany,
      yearsExperience: int.tryParse(state.totalExperience) ?? 0,
      currentLocation: state.currentLocation,
      preferredLocation: state.preferredLocation,
      source: state.source,
      visaStatus: state.visaStatus,
      currentSalary: state.currentSalary,
      expectedSalary: state.expectedSalary,
      salaryCurrency: AppConfig.defaultSalaryCurrency,
      noticePeriod: int.tryParse(state.noticePeriod) ?? 0,
      linkedInProfile: state.linkedIn,
      educationEntries: state.educationEntries,
      workExperienceEntries: state.workExperienceEntries,
      skills: state.skills,
      githubLink: state.github,
      portfolioLink: state.portfolio,
      willingToRelocate:
          state.willingToRelocate == RegisterRelocatePreference.yes,
      createdBy: AppConfig.defaultRegistrationCreatedBy,
    );
  }

  Future<void> createAccount() async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      clearToast: true,
      clearRegisterFailureMessage: true,
      clearRegisterSuccessMessage: true,
    );

    try {
      final input = _buildInput();
      final result = await ref
          .read(registerCandidateUseCaseProvider)
          .call(input);

      state = state.copyWith(
        isLoading: false,
        clearForm: true,
        registerSuccessEventId: state.registerSuccessEventId + 1,
        registerSuccessMessage: result.message,
      );
    } on AppException catch (error) {
      state = state.copyWith(isLoading: false);
      _emitToast(
        RegisterToastType.createAccountFailed,
        failureMessage: error.message,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
      _emitToast(RegisterToastType.createAccountFailed);
    }
  }

  void reset() => state = const RegisterState();

  String toastMessage(AppLocalizations l10n, RegisterToastType type) {
    return switch (type) {
      RegisterToastType.firstNameRequired => l10n.authFirstNameRequired,
      RegisterToastType.lastNameRequired => l10n.authLastNameRequired,
      RegisterToastType.emailRequired => l10n.authEmailRequired,
      RegisterToastType.emailInvalid => l10n.authEmailInvalid,
      RegisterToastType.phoneRequired => l10n.authPhoneRequired,
      RegisterToastType.nationalityRequired => l10n.authNationalityRequired,
      RegisterToastType.educationRequired => l10n.authEducationRequired,
      RegisterToastType.workExperienceRequired =>
        l10n.authWorkExperienceRequired,
      RegisterToastType.skillsRequired => l10n.authSkillsRequired,
      RegisterToastType.skillAlreadyAdded => l10n.authSkillAlreadyAdded,
      RegisterToastType.passwordRequired => l10n.authPasswordRequired,
      RegisterToastType.confirmPasswordRequired =>
        l10n.authConfirmPasswordRequired,
      RegisterToastType.passwordsMismatch => l10n.authPasswordsMismatch,
      RegisterToastType.createAccountFailed => l10n.authCreateAccountFailed,
    };
  }

  bool isInfoToast(RegisterToastType type) => false;
}
