import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';
import 'package:career_portal/features/auth/presentation/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterController extends Notifier<RegisterState> {
  static final _emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  RegisterState build() => const RegisterState();

  void _emitToast(RegisterToastType type) {
    state = state.copyWith(
      toastType: type,
      toastEventId: state.toastEventId + 1,
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

  Future<void> createAccount() async {
    if (state.isLoading) return;
    if (!validateForm()) return;

    state = state.copyWith(isLoading: true, clearToast: true);
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } catch (_) {
      state = state.copyWith(isLoading: false);
      _emitToast(RegisterToastType.createAccountFailed);
      return;
    }
    state = state.copyWith(isLoading: false);
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
