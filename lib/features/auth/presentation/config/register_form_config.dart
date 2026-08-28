import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';

abstract final class RegisterFormConfig {
  RegisterFormConfig._();

  static const List<RegisterGender> genderOptions = RegisterGender.values;

  static String genderLabel(AppLocalizations l10n, RegisterGender gender) {
    return switch (gender) {
      RegisterGender.male => l10n.authGenderMale,
      RegisterGender.female => l10n.authGenderFemale,
      RegisterGender.other => l10n.authGenderOther,
    };
  }

  static const List<RegisterVisaStatus> visaStatusOptions =
      RegisterVisaStatus.values;

  static String visaStatusLabel(
    AppLocalizations l10n,
    RegisterVisaStatus status,
  ) {
    return switch (status) {
      RegisterVisaStatus.transferable => l10n.authVisaStatusTransferable,
      RegisterVisaStatus.notTransferable => l10n.authVisaStatusNotTransferable,
      RegisterVisaStatus.visitVisa => l10n.authVisaStatusVisitVisa,
      RegisterVisaStatus.resident => l10n.authVisaStatusResident,
      RegisterVisaStatus.noVisa => l10n.authVisaStatusNoVisa,
    };
  }

  static List<(RegisterStep, String)> steps(AppLocalizations l10n) {
    return [
      (RegisterStep.personalInfo, l10n.authPersonalInformation),
      (RegisterStep.professionalInfo, l10n.authProfessionalInformation),
      (RegisterStep.socialLinks, l10n.authSocialLinksSection),
      (RegisterStep.education, l10n.authEducation),
      (RegisterStep.workExperience, l10n.authWorkExperience),
      (RegisterStep.security, l10n.authSecurity),
    ];
  }
}
