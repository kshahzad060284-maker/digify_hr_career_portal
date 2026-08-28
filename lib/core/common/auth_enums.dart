enum LoginToastType {
  emailRequired,
  emailInvalid,
  passwordRequired,
  signInFailed,
}

enum RegisterToastType {
  firstNameRequired,
  lastNameRequired,
  emailRequired,
  emailInvalid,
  phoneRequired,
  nationalityRequired,
  educationRequired,
  workExperienceRequired,
  skillsRequired,
  skillAlreadyAdded,
  passwordRequired,
  confirmPasswordRequired,
  passwordsMismatch,
  createAccountFailed,
}

enum RegisterRelocatePreference { yes, no }

enum RegisterExperienceType { fresh, experienced }

enum RegisterGender {
  male('Male'),
  female('Female'),
  other('Other');

  const RegisterGender(this.apiValue);

  final String apiValue;
}

enum RegisterVisaStatus {
  transferable('TRANSFERABLE'),
  notTransferable('NOT_TRANSFERABLE'),
  visitVisa('VISIT_VISA'),
  resident('RESIDENT'),
  noVisa('NO_VISA');

  const RegisterVisaStatus(this.apiValue);

  final String apiValue;
}

enum ForgotPasswordStep { verifyEmail, checkOtp, resetPassword }

enum RegisterStep {
  personalInfo,
  professionalInfo,
  socialLinks,
  education,
  workExperience,
  security,
}
