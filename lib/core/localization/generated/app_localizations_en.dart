// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Career Portal';

  @override
  String get appTagline => 'Find your next opportunity';

  @override
  String get login => 'Login';

  @override
  String get signIn => 'Sign In';

  @override
  String get authBack => 'Back';

  @override
  String get authSignInTitle => 'Welcome Back';

  @override
  String get authSignInSubtitle => 'Sign in to your account';

  @override
  String get authEmailAddress => 'Email Address';

  @override
  String get authPassword => 'Password';

  @override
  String get authEmailHint => 'you@company.com';

  @override
  String get authPasswordHint => 'Enter your password';

  @override
  String get authEmailRequired => 'Please enter your email address';

  @override
  String get authEmailInvalid => 'Please enter a valid email address';

  @override
  String get authPasswordRequired => 'Please enter your password';

  @override
  String get authNoAccountPrompt => 'Don\'t have an account? ';

  @override
  String get authRegisterNow => 'Register now';

  @override
  String get authRegisterComingSoon => 'Registration is coming soon';

  @override
  String get authSignInFailed => 'Sign in failed. Please try again.';

  @override
  String get authCreateAccountTitle => 'Create Your Account';

  @override
  String get authCreateAccountSubtitle =>
      'Join us and start your career journey';

  @override
  String get authFirstName => 'First Name';

  @override
  String get authMiddleName => 'Middle Name';

  @override
  String get authLastName => 'Last Name';

  @override
  String get authFirstNameHint => 'Enter your first name';

  @override
  String get authMiddleNameHint => 'Optional';

  @override
  String get authLastNameHint => 'Enter your last name';

  @override
  String get authPhoneNumber => 'Phone Number';

  @override
  String get authPhoneHint => '5XX XXX XXXX';

  @override
  String get phoneCountrySearchHint => 'Search country...';

  @override
  String get authProfessionalInformation => 'Professional Information';

  @override
  String get authCurrentCompany => 'Current Company';

  @override
  String get authCurrentCompanyHint => 'Company name';

  @override
  String get authCurrentTitle => 'Current Title';

  @override
  String get authCurrentTitleHint => 'e.g., Software Engineer';

  @override
  String get authTotalExperience => 'Total Experience (Years)';

  @override
  String get authTotalExperienceHint => 'e.g., 5';

  @override
  String get authCurrentLocation => 'Current Location';

  @override
  String get authLocationHint => 'City, State';

  @override
  String get authSource => 'Source';

  @override
  String get authSourceHint => 'e.g., CAREER_SITE';

  @override
  String get authNoticePeriod => 'Notice Period (Days)';

  @override
  String get authNoticePeriodHint => 'e.g., 30';

  @override
  String get authWillingToRelocate => 'Willing to Relocate';

  @override
  String get authYes => 'Yes';

  @override
  String get authNo => 'No';

  @override
  String get authCurrentSalaryOptional => 'Current Salary (Optional)';

  @override
  String get authExpectedSalaryOptional => 'Expected Salary (Optional)';

  @override
  String get authSalaryExampleHint => 'e.g., \$80,000';

  @override
  String get authExpectedSalaryExampleHint => 'e.g., \$100,000';

  @override
  String get authSocialLinksSection => 'Social & Professional Links';

  @override
  String get authLinkedInProfile => 'LinkedIn Profile';

  @override
  String get authLinkedInHint => 'https://linkedin.com/in/yourprofile';

  @override
  String get authGitHubProfile => 'GitHub Profile';

  @override
  String get authGitHubHint => 'https://github.com/yourusername';

  @override
  String get authPortfolioWebsite => 'Portfolio/Website';

  @override
  String get authPortfolioHint => 'https://yourportfolio.com';

  @override
  String get authEducationOptional => 'Education (Optional)';

  @override
  String get authAddEducation => 'Add Education';

  @override
  String get authEducationEmpty =>
      'No education added yet. Click \"Add Education\" to include your academic background.';

  @override
  String get authWorkExperienceOptional => 'Work Experience (Optional)';

  @override
  String get authAddExperience => 'Add Experience';

  @override
  String get authWorkExperienceEmpty =>
      'No work experience added yet. Click \"Add Experience\" to include your professional background.';

  @override
  String get authSecurity => 'Security';

  @override
  String get authConfirmPassword => 'Confirm Password';

  @override
  String get authConfirmPasswordHint => 'Re-enter your password';

  @override
  String get authCreateAccount => 'Create Account';

  @override
  String get authAlreadyHaveAccountPrompt => 'Already have an account? ';

  @override
  String get authFirstNameRequired => 'Please enter your first name';

  @override
  String get authLastNameRequired => 'Please enter your last name';

  @override
  String get authPhoneRequired => 'Please enter your phone number';

  @override
  String get authConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get authPasswordsMismatch => 'Passwords do not match';

  @override
  String get authCreateAccountFailed =>
      'Could not create account. Please try again.';

  @override
  String get authCreateAccountSuccess =>
      'Registration successful. Please sign in to continue.';

  @override
  String get authLoggedInLabel => 'Signed in';

  @override
  String get authSignInSuccess => 'Signed in successfully.';

  @override
  String authWelcomeBackUser(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get authLogout => 'Log out';

  @override
  String get authLogoutConfirmTitle => 'Log out?';

  @override
  String get authLogoutConfirmMessage =>
      'Are you sure you want to log out of your account?';

  @override
  String get authLogoutSuccess => 'You have been logged out.';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSaveChanges => 'Save Changes';

  @override
  String get authRemoveEducationTitle => 'Remove education?';

  @override
  String get authRemoveEducationMessage =>
      'Are you sure you want to remove this education entry? This action cannot be undone.';

  @override
  String get authRemoveWorkExperienceTitle => 'Remove work experience?';

  @override
  String get authRemoveWorkExperienceMessage =>
      'Are you sure you want to remove this work experience entry? This action cannot be undone.';

  @override
  String get authPresent => 'Present';

  @override
  String get authAddEducationTitle => 'Add Education';

  @override
  String get authEditEducationTitle => 'Edit Education';

  @override
  String get authDegreeName => 'Degree Name';

  @override
  String get authDegreeNameHint => 'e.g. MBA';

  @override
  String get authDegreeNameRequired => 'Degree name is required';

  @override
  String get authInstitutionName => 'Institution Name';

  @override
  String get authInstitutionNameHint =>
      'e.g. Hult International Business School';

  @override
  String get authInstitutionNameRequired => 'Institution name is required';

  @override
  String get authFieldOfStudy => 'Field of Study';

  @override
  String get authFieldOfStudyHint => 'e.g. Business Administration';

  @override
  String get authFieldOfStudyRequired => 'Field of study is required';

  @override
  String get authStartDate => 'Start Date';

  @override
  String get authEndDate => 'End Date';

  @override
  String get authDateHint => 'dd/mm/yyyy';

  @override
  String get authStartDateRequired => 'Start date is required';

  @override
  String get authEndDateRequired => 'End date is required';

  @override
  String get authGrade => 'Grade';

  @override
  String get authSelectGrade => 'Select grade';

  @override
  String get authGradeRequired => 'Grade is required';

  @override
  String get authEducationDescription => 'Description';

  @override
  String get authEducationDescriptionHint => 'e.g. Master Degree';

  @override
  String get authAddWorkExperienceTitle => 'Add Work Experience';

  @override
  String get authEditWorkExperienceTitle => 'Edit Work Experience';

  @override
  String get authCompanyName => 'Company Name';

  @override
  String get authCompanyNameHint => 'e.g. Digify HR';

  @override
  String get authCompanyNameRequired => 'Company name is required';

  @override
  String get authJobTitle => 'Job Title';

  @override
  String get authJobTitleHint => 'e.g. Business Applications Manager';

  @override
  String get authJobTitleRequired => 'Job title is required';

  @override
  String get authWorkLocation => 'Location';

  @override
  String get authWorkLocationHint => 'e.g. Kuwait';

  @override
  String get authWorkLocationRequired => 'Location is required';

  @override
  String get authCurrentJob => 'Current Job';

  @override
  String get authSelectCurrentJob => 'Select';

  @override
  String get authWorkDescription => 'Description';

  @override
  String get authWorkDescriptionHint => 'e.g. Managing enterprise applications';

  @override
  String get register => 'Register';

  @override
  String get welcome => 'Welcome';

  @override
  String get browseJobs => 'Browse jobs';

  @override
  String get navHome => 'Home';

  @override
  String get navJobs => 'Jobs';

  @override
  String get navCompanies => 'Companies';

  @override
  String get navAbout => 'About';

  @override
  String get dashboardWelcomeTitle => 'Welcome to your dashboard';

  @override
  String get dashboardWelcomeSubtitle =>
      'Overview of your career portal activity and modules.';

  @override
  String get dashboardJoinTeamTitle => 'Join Our Team';

  @override
  String get dashboardJoinTeamSubtitle =>
      'Discover your next career opportunity and be part of something amazing';

  @override
  String get dashboardHeroBadge => 'We\'re hiring';

  @override
  String get dashboardJobSearchPlaceholder =>
      'Search for jobs by title, department, or keyword...';

  @override
  String get dashboardFilterAllLocations => 'All Locations';

  @override
  String get dashboardFilterAllDepartments => 'All Departments';

  @override
  String get dashboardFilterAllEmploymentTypes => 'All Types';

  @override
  String get dashboardFilterLocationLabel => 'Location';

  @override
  String get dashboardFilterDepartmentLabel => 'Department';

  @override
  String get dashboardFilterEmploymentTypeLabel => 'Job type';

  @override
  String get dashboardFilterClearAll => 'Clear all';

  @override
  String get dashboardOpenRolesHeading => 'Open roles';

  @override
  String dashboardPositionsAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count positions available',
      one: '1 position available',
    );
    return '$_temp0';
  }

  @override
  String dashboardJobOpenings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count openings',
      one: '1 opening',
    );
    return '$_temp0';
  }

  @override
  String get dashboardJobUrgentHiring => 'Urgent Hiring';

  @override
  String get dashboardJobApplicationStatusApplied => 'Applied';

  @override
  String get dashboardJobApplicationStatusNotApplied => 'Not Applied';

  @override
  String get dashboardJobViewDetails => 'Job Details';

  @override
  String get dashboardJobCopyLink => 'Copy link';

  @override
  String get dashboardJobLinkCopied => 'Job link copied to clipboard';

  @override
  String get dashboardEmptyJobsTitle => 'No matching roles';

  @override
  String get dashboardNoJobsFound =>
      'No positions match your search or filters. Try adjusting your filters or search terms.';

  @override
  String get dashboardHeaderMyOffers => 'My Offers';

  @override
  String get dashboardHeaderMyApplications => 'My Applications';

  @override
  String get candidateOffersTitle => 'My Offers';

  @override
  String get candidateOffersSubtitle =>
      'View job offers sent to you by companies.';

  @override
  String get candidateOffersEmpty =>
      'You don\'t have any offers yet. When a company sends you an offer, it will appear here.';

  @override
  String get candidateOffersLoadFailed =>
      'Could not load your offers. Please try again.';

  @override
  String candidateOffersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count offers',
      one: '1 offer',
    );
    return '$_temp0';
  }

  @override
  String get candidateOfferStatusPending => 'Pending';

  @override
  String get candidateOfferStatusAccepted => 'Accepted';

  @override
  String get candidateOfferStatusDeclined => 'Declined';

  @override
  String get candidateOfferStatusExpired => 'Expired';

  @override
  String candidateOfferSentOn(String date) {
    return 'Sent $date';
  }

  @override
  String candidateOfferExpiresOn(String date) {
    return 'Expires $date';
  }

  @override
  String get candidateOfferView => 'View Offer';

  @override
  String get candidateOfferAccept => 'Accept';

  @override
  String get candidateOfferDecline => 'Decline';

  @override
  String get candidateOfferAcceptTitle => 'Accept Offer';

  @override
  String get candidateOfferAcceptMessage =>
      'Are you sure you want to accept this job offer?';

  @override
  String get candidateOfferDeclineTitle => 'Decline Offer';

  @override
  String get candidateOfferDeclineMessage =>
      'Please provide a reason for declining this offer.';

  @override
  String get candidateOfferDeclineCommentsLabel => 'Decline reason';

  @override
  String get candidateOfferDeclineCommentsRequired =>
      'Please enter a reason for declining the offer.';

  @override
  String get candidateOfferAcceptSuccess => 'Offer accepted successfully.';

  @override
  String get candidateOfferDeclineSuccess => 'Offer declined successfully.';

  @override
  String get candidateOfferAcceptFailed =>
      'Could not accept the offer. Please try again.';

  @override
  String get candidateOfferDeclineFailed =>
      'Could not decline the offer. Please try again.';

  @override
  String get candidateApplicationsTitle => 'My Applications';

  @override
  String get candidateApplicationsSubtitle =>
      'Track the jobs you have applied for.';

  @override
  String get candidateApplicationsEmpty =>
      'You haven\'t applied to any jobs yet. When you apply, your applications will appear here.';

  @override
  String get candidateApplicationsLoadFailed =>
      'Could not load your applications. Please try again.';

  @override
  String candidateApplicationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count applications',
      one: '1 application',
    );
    return '$_temp0';
  }

  @override
  String candidateApplicationAppliedOn(String date) {
    return 'Applied $date';
  }

  @override
  String get candidateApplicationViewJob => 'View Job';

  @override
  String get dashboardJobsLoadFailed =>
      'Could not load job postings. Please try again.';

  @override
  String get commonRetry => 'Retry';

  @override
  String paginationShowingRange(int start, int end, int total) {
    return 'Showing $start - $end of $total items';
  }

  @override
  String paginationPageOf(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String dashboardJobDetailTitle(String jobId) {
    return 'Job #$jobId';
  }

  @override
  String get dashboardJobDetailAboutRole => 'About the Role';

  @override
  String get dashboardJobDetailResponsibilities => 'Responsibilities';

  @override
  String get dashboardJobDetailQualifications => 'Qualifications';

  @override
  String get dashboardJobDetailNotFound => 'This job could not be found.';

  @override
  String get dashboardJobDetailLoadFailed =>
      'Could not load job details. Please try again.';

  @override
  String get dashboardJobDetailBack => 'Back to all jobs';

  @override
  String get dashboardJobDetailSignInToApply => 'Sign in to Apply';

  @override
  String get dashboardJobDetailApply => 'Apply';

  @override
  String get dashboardJobDetailApplied => 'Applied';

  @override
  String get dashboardJobDetailAlreadyApplied =>
      'You have already applied for this role';

  @override
  String get dashboardJobApplyDialogTitle => 'Apply for Job';

  @override
  String dashboardJobApplyDialogSubtitle(String jobTitle) {
    return '$jobTitle';
  }

  @override
  String get dashboardJobApplyResume => 'Resume';

  @override
  String get dashboardJobApplyResumeHint => 'Upload PDF, DOC, or DOCX';

  @override
  String get dashboardJobApplyChooseFile => 'Choose file';

  @override
  String get dashboardJobApplySourceRequired => 'Please enter a source';

  @override
  String get dashboardJobApplyResumeRequired => 'Please upload your resume';

  @override
  String get dashboardJobApplySubmit => 'Submit application';

  @override
  String get dashboardJobApplySuccess => 'Your application has been submitted.';

  @override
  String get dashboardJobApplyFailed =>
      'Could not submit your application. Please try again.';

  @override
  String get dashboardJobApplySessionRequired =>
      'Please sign in again to apply for this job.';

  @override
  String get dashboardJobApplyResumeInvalid =>
      'Could not read the selected resume file.';

  @override
  String get dashboardJobDetailSidebarTitle => 'Job Details';

  @override
  String get dashboardJobDetailSalaryRange => 'Salary Range';

  @override
  String get dashboardJobDetailOpeningsLabel => 'Openings';

  @override
  String dashboardJobDetailPositionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count positions',
      one: '1 position',
    );
    return '$_temp0';
  }

  @override
  String get dashboardJobDetailStartDate => 'Start Date';

  @override
  String get dashboardJobDetailLevel => 'Level';

  @override
  String get dashboardJobDetailQuestionsTitle => 'Questions?';

  @override
  String get dashboardJobDetailQuestionsBody =>
      'Our recruitment team is here to help. Feel free to reach out with any questions about this role.';

  @override
  String get footerTagline =>
      'Find your next opportunity and grow with a team that invests in you.';

  @override
  String get footerCopyright => '© 2026 Career Portal. All rights reserved.';

  @override
  String get footerPrivacy => 'Privacy Policy';

  @override
  String get footerTerms => 'Terms & Conditions';

  @override
  String get footerContact => 'Contact';

  @override
  String get footerCompanyTitle => 'Company';

  @override
  String get footerCompanyAboutUs => 'About Us';

  @override
  String get footerCompanyOurTeam => 'Our Team';

  @override
  String get footerCompanyPartners => 'Partners';

  @override
  String get footerCompanyForCandidates => 'For Candidates';

  @override
  String get footerCompanyForEmployers => 'For Employers';

  @override
  String get footerJobCategoriesTitle => 'Job Categories';

  @override
  String get footerCategoryTelecommunications => 'Telecommunications';

  @override
  String get footerCategoryHotelsTourism => 'Hotels & Tourism';

  @override
  String get footerCategoryConstruction => 'Construction';

  @override
  String get footerCategoryEducation => 'Education';

  @override
  String get footerCategoryFinancialServices => 'Financial Services';

  @override
  String get footerNewsletterTitle => 'Newsletter';

  @override
  String get footerNewsletterDescription =>
      'Get the latest open roles and career tips in your inbox.';

  @override
  String get footerNewsletterEmailHint => 'Email Address';

  @override
  String get footerNewsletterSubscribe => 'Subscribe now';

  @override
  String get footerNewsletterEmailRequired => 'Please enter your email address';

  @override
  String get footerNewsletterSuccess =>
      'Thanks for subscribing. We\'ll keep you updated.';

  @override
  String get timePickerTitle => 'Set Time';

  @override
  String get timePickerSubtitle => 'Tap the number to type';

  @override
  String get timePickerHourLabel => 'HOUR';

  @override
  String get timePickerMinuteLabel => 'MINUTE';

  @override
  String get timePickerPeriodLabel => 'PERIOD';

  @override
  String get timePickerCancel => 'Cancel';

  @override
  String get timePickerUpdate => 'Update Time';

  @override
  String get timePickerSelectHint => 'Select Time';

  @override
  String get timePickerAm => 'AM';

  @override
  String get timePickerPm => 'PM';

  @override
  String get datePickerSelectYear => 'Select Year';

  @override
  String get datePickerSelectDate => 'Select Date';
}
