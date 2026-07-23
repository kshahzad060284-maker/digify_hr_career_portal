import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/utils/phone_number_utils.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:career_portal/features/auth/presentation/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterController extends Notifier<RegisterState> {
  static final _emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

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

  void onCurrentCompanyChanged(String value) =>
      state = state.copyWith(currentCompany: value, clearToast: true);

  void onCurrentTitleChanged(String value) =>
      state = state.copyWith(currentTitle: value, clearToast: true);

  void onTotalExperienceChanged(String value) =>
      state = state.copyWith(totalExperience: value, clearToast: true);

  void onCurrentLocationChanged(String value) =>
      state = state.copyWith(currentLocation: value, clearToast: true);

  void onSourceChanged(String value) =>
      state = state.copyWith(source: value, clearToast: true);

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

  bool validateForm() {
    if (state.firstName.trim().isEmpty) {
      _emitToast(RegisterToastType.firstNameRequired);
      return false;
    }
    if (state.lastName.trim().isEmpty) {
      _emitToast(RegisterToastType.lastNameRequired);
      return false;
    }
    final email = state.email.trim();
    if (email.isEmpty) {
      _emitToast(RegisterToastType.emailRequired);
      return false;
    }
    if (!_emailPattern.hasMatch(email)) {
      _emitToast(RegisterToastType.emailInvalid);
      return false;
    }
    if (state.phone.trim().isEmpty) {
      _emitToast(RegisterToastType.phoneRequired);
      return false;
    }
    if (state.password.isEmpty) {
      _emitToast(RegisterToastType.passwordRequired);
      return false;
    }
    if (state.confirmPassword.isEmpty) {
      _emitToast(RegisterToastType.confirmPasswordRequired);
      return false;
    }
    if (state.password != state.confirmPassword) {
      _emitToast(RegisterToastType.passwordsMismatch);
      return false;
    }
    return true;
  }

  RegisterCandidateInput _buildInput() {
    final email = state.email.trim();
    final phone =
        PhoneNumberUtils.fullPhoneNumber(
          dialCode: state.phoneDialCode,
          localNumber: state.phone,
        ) ??
        '';

    return RegisterCandidateInput(
      enterpriseId: ref.read(enterpriseIdProvider),
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      middleName: state.middleName.trim(),
      email: email,
      password: state.password,
      phone: phone,
      currentTitle: state.currentTitle.trim(),
      currentEmployer: state.currentCompany.trim(),
      yearsExperience: int.tryParse(state.totalExperience.trim()) ?? 0,
      currentLocation: state.currentLocation.trim(),
      source: state.source.trim(),
      expectedSalary: _normalizeSalary(state.expectedSalary),
      salaryCurrency: AppConfig.defaultSalaryCurrency,
      noticePeriod: int.tryParse(state.noticePeriod.trim()) ?? 0,
      linkedInProfile: state.linkedIn.trim(),
      educationEntries: state.educationEntries,
      workExperienceEntries: state.workExperienceEntries,
      githubLink: state.github.trim(),
      portfolioLink: state.portfolio.trim(),
      willingToRelocate:
          state.willingToRelocate == RegisterRelocatePreference.yes,
      createdBy: email,
    );
  }

  String _normalizeSalary(String value) {
    return value.replaceAll(RegExp(r'[^0-9.]'), '').trim();
  }

  Future<void> createAccount() async {
    if (state.isLoading) return;
    if (!validateForm()) return;

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
      RegisterToastType.passwordRequired => l10n.authPasswordRequired,
      RegisterToastType.confirmPasswordRequired =>
        l10n.authConfirmPasswordRequired,
      RegisterToastType.passwordsMismatch => l10n.authPasswordsMismatch,
      RegisterToastType.createAccountFailed => l10n.authCreateAccountFailed,
    };
  }

  bool isInfoToast(RegisterToastType type) => false;
}
