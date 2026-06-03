import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Career Portal'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Find your next opportunity'**
  String get appTagline;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @authBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get authBack;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authWelcomeBack;

  /// No description provided for @authSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get authSignInSubtitle;

  /// No description provided for @authEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get authEmailAddress;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@company.com'**
  String get authEmailHint;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authPasswordHint;

  /// No description provided for @authEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get authEmailRequired;

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get authPasswordRequired;

  /// No description provided for @authNoAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get authNoAccountPrompt;

  /// No description provided for @authRegisterNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get authRegisterNow;

  /// No description provided for @authRegisterComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Registration is coming soon'**
  String get authRegisterComingSoon;

  /// No description provided for @authSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed. Please try again.'**
  String get authSignInFailed;

  /// No description provided for @authCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get authCreateAccountTitle;

  /// No description provided for @authCreateAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join us and start your career journey'**
  String get authCreateAccountSubtitle;

  /// No description provided for @authFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get authFirstName;

  /// No description provided for @authMiddleName.
  ///
  /// In en, this message translates to:
  /// **'Middle Name'**
  String get authMiddleName;

  /// No description provided for @authLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get authLastName;

  /// No description provided for @authFirstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get authFirstNameHint;

  /// No description provided for @authMiddleNameHint.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get authMiddleNameHint;

  /// No description provided for @authLastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get authLastNameHint;

  /// No description provided for @authPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get authPhoneNumber;

  /// No description provided for @authPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'5XX XXX XXXX'**
  String get authPhoneHint;

  /// No description provided for @phoneCountrySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country...'**
  String get phoneCountrySearchHint;

  /// No description provided for @authProfessionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Professional Information'**
  String get authProfessionalInformation;

  /// No description provided for @authCurrentCompany.
  ///
  /// In en, this message translates to:
  /// **'Current Company'**
  String get authCurrentCompany;

  /// No description provided for @authCurrentCompanyHint.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get authCurrentCompanyHint;

  /// No description provided for @authCurrentTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Title'**
  String get authCurrentTitle;

  /// No description provided for @authCurrentTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Software Engineer'**
  String get authCurrentTitleHint;

  /// No description provided for @authTotalExperience.
  ///
  /// In en, this message translates to:
  /// **'Total Experience (Years)'**
  String get authTotalExperience;

  /// No description provided for @authTotalExperienceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 5'**
  String get authTotalExperienceHint;

  /// No description provided for @authCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get authCurrentLocation;

  /// No description provided for @authLocationHint.
  ///
  /// In en, this message translates to:
  /// **'City, State'**
  String get authLocationHint;

  /// No description provided for @authWillingToRelocate.
  ///
  /// In en, this message translates to:
  /// **'Willing to Relocate'**
  String get authWillingToRelocate;

  /// No description provided for @authYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get authYes;

  /// No description provided for @authNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get authNo;

  /// No description provided for @authCurrentSalaryOptional.
  ///
  /// In en, this message translates to:
  /// **'Current Salary (Optional)'**
  String get authCurrentSalaryOptional;

  /// No description provided for @authExpectedSalaryOptional.
  ///
  /// In en, this message translates to:
  /// **'Expected Salary (Optional)'**
  String get authExpectedSalaryOptional;

  /// No description provided for @authSalaryExampleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., \$80,000'**
  String get authSalaryExampleHint;

  /// No description provided for @authExpectedSalaryExampleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., \$100,000'**
  String get authExpectedSalaryExampleHint;

  /// No description provided for @authSocialLinksSection.
  ///
  /// In en, this message translates to:
  /// **'Social & Professional Links'**
  String get authSocialLinksSection;

  /// No description provided for @authLinkedInProfile.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn Profile'**
  String get authLinkedInProfile;

  /// No description provided for @authLinkedInHint.
  ///
  /// In en, this message translates to:
  /// **'https://linkedin.com/in/yourprofile'**
  String get authLinkedInHint;

  /// No description provided for @authGitHubProfile.
  ///
  /// In en, this message translates to:
  /// **'GitHub Profile'**
  String get authGitHubProfile;

  /// No description provided for @authGitHubHint.
  ///
  /// In en, this message translates to:
  /// **'https://github.com/yourusername'**
  String get authGitHubHint;

  /// No description provided for @authPortfolioWebsite.
  ///
  /// In en, this message translates to:
  /// **'Portfolio/Website'**
  String get authPortfolioWebsite;

  /// No description provided for @authPortfolioHint.
  ///
  /// In en, this message translates to:
  /// **'https://yourportfolio.com'**
  String get authPortfolioHint;

  /// No description provided for @authEducationOptional.
  ///
  /// In en, this message translates to:
  /// **'Education (Optional)'**
  String get authEducationOptional;

  /// No description provided for @authAddEducation.
  ///
  /// In en, this message translates to:
  /// **'Add Education'**
  String get authAddEducation;

  /// No description provided for @authEducationEmpty.
  ///
  /// In en, this message translates to:
  /// **'No education added yet. Click \"Add Education\" to include your academic background.'**
  String get authEducationEmpty;

  /// No description provided for @authWorkExperienceOptional.
  ///
  /// In en, this message translates to:
  /// **'Work Experience (Optional)'**
  String get authWorkExperienceOptional;

  /// No description provided for @authAddExperience.
  ///
  /// In en, this message translates to:
  /// **'Add Experience'**
  String get authAddExperience;

  /// No description provided for @authWorkExperienceEmpty.
  ///
  /// In en, this message translates to:
  /// **'No work experience added yet. Click \"Add Experience\" to include your professional background.'**
  String get authWorkExperienceEmpty;

  /// No description provided for @authSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get authSecurity;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPassword;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get authConfirmPasswordHint;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authCreateAccount;

  /// No description provided for @authAlreadyHaveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authAlreadyHaveAccountPrompt;

  /// No description provided for @authFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get authFirstNameRequired;

  /// No description provided for @authLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get authLastNameRequired;

  /// No description provided for @authPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get authPhoneRequired;

  /// No description provided for @authConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get authConfirmPasswordRequired;

  /// No description provided for @authPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get authPasswordsMismatch;

  /// No description provided for @authCreateAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create account. Please try again.'**
  String get authCreateAccountFailed;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get commonSaveChanges;

  /// No description provided for @authRemoveEducationTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove education?'**
  String get authRemoveEducationTitle;

  /// No description provided for @authRemoveEducationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this education entry? This action cannot be undone.'**
  String get authRemoveEducationMessage;

  /// No description provided for @authRemoveWorkExperienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove work experience?'**
  String get authRemoveWorkExperienceTitle;

  /// No description provided for @authRemoveWorkExperienceMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this work experience entry? This action cannot be undone.'**
  String get authRemoveWorkExperienceMessage;

  /// No description provided for @authPresent.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get authPresent;

  /// No description provided for @authAddEducationTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Education'**
  String get authAddEducationTitle;

  /// No description provided for @authEditEducationTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Education'**
  String get authEditEducationTitle;

  /// No description provided for @authDegreeName.
  ///
  /// In en, this message translates to:
  /// **'Degree Name'**
  String get authDegreeName;

  /// No description provided for @authDegreeNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. MBA'**
  String get authDegreeNameHint;

  /// No description provided for @authDegreeNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Degree name is required'**
  String get authDegreeNameRequired;

  /// No description provided for @authInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Institution Name'**
  String get authInstitutionName;

  /// No description provided for @authInstitutionNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Hult International Business School'**
  String get authInstitutionNameHint;

  /// No description provided for @authInstitutionNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Institution name is required'**
  String get authInstitutionNameRequired;

  /// No description provided for @authFieldOfStudy.
  ///
  /// In en, this message translates to:
  /// **'Field of Study'**
  String get authFieldOfStudy;

  /// No description provided for @authFieldOfStudyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Business Administration'**
  String get authFieldOfStudyHint;

  /// No description provided for @authFieldOfStudyRequired.
  ///
  /// In en, this message translates to:
  /// **'Field of study is required'**
  String get authFieldOfStudyRequired;

  /// No description provided for @authStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get authStartDate;

  /// No description provided for @authEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get authEndDate;

  /// No description provided for @authDateHint.
  ///
  /// In en, this message translates to:
  /// **'dd/mm/yyyy'**
  String get authDateHint;

  /// No description provided for @authStartDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Start date is required'**
  String get authStartDateRequired;

  /// No description provided for @authEndDateRequired.
  ///
  /// In en, this message translates to:
  /// **'End date is required'**
  String get authEndDateRequired;

  /// No description provided for @authGrade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get authGrade;

  /// No description provided for @authSelectGrade.
  ///
  /// In en, this message translates to:
  /// **'Select grade'**
  String get authSelectGrade;

  /// No description provided for @authGradeRequired.
  ///
  /// In en, this message translates to:
  /// **'Grade is required'**
  String get authGradeRequired;

  /// No description provided for @authEducationDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get authEducationDescription;

  /// No description provided for @authEducationDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Master Degree'**
  String get authEducationDescriptionHint;

  /// No description provided for @authAddWorkExperienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Work Experience'**
  String get authAddWorkExperienceTitle;

  /// No description provided for @authEditWorkExperienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Work Experience'**
  String get authEditWorkExperienceTitle;

  /// No description provided for @authCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get authCompanyName;

  /// No description provided for @authCompanyNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Digify HR'**
  String get authCompanyNameHint;

  /// No description provided for @authCompanyNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get authCompanyNameRequired;

  /// No description provided for @authJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get authJobTitle;

  /// No description provided for @authJobTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Business Applications Manager'**
  String get authJobTitleHint;

  /// No description provided for @authJobTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Job title is required'**
  String get authJobTitleRequired;

  /// No description provided for @authWorkLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get authWorkLocation;

  /// No description provided for @authWorkLocationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Kuwait'**
  String get authWorkLocationHint;

  /// No description provided for @authWorkLocationRequired.
  ///
  /// In en, this message translates to:
  /// **'Location is required'**
  String get authWorkLocationRequired;

  /// No description provided for @authCurrentJob.
  ///
  /// In en, this message translates to:
  /// **'Current Job'**
  String get authCurrentJob;

  /// No description provided for @authSelectCurrentJob.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get authSelectCurrentJob;

  /// No description provided for @authWorkDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get authWorkDescription;

  /// No description provided for @authWorkDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Managing enterprise applications'**
  String get authWorkDescriptionHint;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @browseJobs.
  ///
  /// In en, this message translates to:
  /// **'Browse jobs'**
  String get browseJobs;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navJobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get navJobs;

  /// No description provided for @navCompanies.
  ///
  /// In en, this message translates to:
  /// **'Companies'**
  String get navCompanies;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @dashboardWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to your dashboard'**
  String get dashboardWelcomeTitle;

  /// No description provided for @dashboardWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Overview of your career portal activity and modules.'**
  String get dashboardWelcomeSubtitle;

  /// No description provided for @dashboardJoinTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Our Team'**
  String get dashboardJoinTeamTitle;

  /// No description provided for @dashboardJoinTeamSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover your next career opportunity and be part of something amazing'**
  String get dashboardJoinTeamSubtitle;

  /// No description provided for @dashboardJobSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search for jobs by title, department, or keyword...'**
  String get dashboardJobSearchPlaceholder;

  /// No description provided for @dashboardFilterAllLocations.
  ///
  /// In en, this message translates to:
  /// **'All Locations'**
  String get dashboardFilterAllLocations;

  /// No description provided for @dashboardPositionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 position available} other{{count} positions available}}'**
  String dashboardPositionsAvailable(int count);

  /// No description provided for @dashboardJobOpenings.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 opening} other{{count} openings}}'**
  String dashboardJobOpenings(int count);

  /// No description provided for @dashboardJobUrgentHiring.
  ///
  /// In en, this message translates to:
  /// **'Urgent Hiring'**
  String get dashboardJobUrgentHiring;

  /// No description provided for @dashboardNoJobsFound.
  ///
  /// In en, this message translates to:
  /// **'No positions match your search or filters.'**
  String get dashboardNoJobsFound;

  /// No description provided for @dashboardJobDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Job #{jobId}'**
  String dashboardJobDetailTitle(String jobId);

  /// No description provided for @dashboardJobDetailAboutRole.
  ///
  /// In en, this message translates to:
  /// **'About the Role'**
  String get dashboardJobDetailAboutRole;

  /// No description provided for @dashboardJobDetailResponsibilities.
  ///
  /// In en, this message translates to:
  /// **'Responsibilities'**
  String get dashboardJobDetailResponsibilities;

  /// No description provided for @dashboardJobDetailQualifications.
  ///
  /// In en, this message translates to:
  /// **'Qualifications'**
  String get dashboardJobDetailQualifications;

  /// No description provided for @dashboardJobDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'This job could not be found.'**
  String get dashboardJobDetailNotFound;

  /// No description provided for @dashboardJobDetailBack.
  ///
  /// In en, this message translates to:
  /// **'Back to all jobs'**
  String get dashboardJobDetailBack;

  /// No description provided for @dashboardJobDetailSignInToApply.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Apply'**
  String get dashboardJobDetailSignInToApply;

  /// No description provided for @dashboardJobDetailSidebarTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get dashboardJobDetailSidebarTitle;

  /// No description provided for @dashboardJobDetailSalaryRange.
  ///
  /// In en, this message translates to:
  /// **'Salary Range'**
  String get dashboardJobDetailSalaryRange;

  /// No description provided for @dashboardJobDetailOpeningsLabel.
  ///
  /// In en, this message translates to:
  /// **'Openings'**
  String get dashboardJobDetailOpeningsLabel;

  /// No description provided for @dashboardJobDetailPositionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 position} other{{count} positions}}'**
  String dashboardJobDetailPositionsCount(int count);

  /// No description provided for @dashboardJobDetailStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get dashboardJobDetailStartDate;

  /// No description provided for @dashboardJobDetailLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get dashboardJobDetailLevel;

  /// No description provided for @dashboardJobDetailQuestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions?'**
  String get dashboardJobDetailQuestionsTitle;

  /// No description provided for @dashboardJobDetailQuestionsBody.
  ///
  /// In en, this message translates to:
  /// **'Our recruitment team is here to help. Feel free to reach out with any questions about this role.'**
  String get dashboardJobDetailQuestionsBody;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'A clean header-content-footer layout for the web.'**
  String get footerTagline;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Career Portal. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get footerPrivacy;

  /// No description provided for @footerTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get footerTerms;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get footerContact;

  /// No description provided for @timePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Time'**
  String get timePickerTitle;

  /// No description provided for @timePickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the number to type'**
  String get timePickerSubtitle;

  /// No description provided for @timePickerHourLabel.
  ///
  /// In en, this message translates to:
  /// **'HOUR'**
  String get timePickerHourLabel;

  /// No description provided for @timePickerMinuteLabel.
  ///
  /// In en, this message translates to:
  /// **'MINUTE'**
  String get timePickerMinuteLabel;

  /// No description provided for @timePickerPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'PERIOD'**
  String get timePickerPeriodLabel;

  /// No description provided for @timePickerCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get timePickerCancel;

  /// No description provided for @timePickerUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Time'**
  String get timePickerUpdate;

  /// No description provided for @timePickerSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get timePickerSelectHint;

  /// No description provided for @timePickerAm.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get timePickerAm;

  /// No description provided for @timePickerPm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get timePickerPm;

  /// No description provided for @datePickerSelectYear.
  ///
  /// In en, this message translates to:
  /// **'Select Year'**
  String get datePickerSelectYear;

  /// No description provided for @datePickerSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get datePickerSelectDate;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
