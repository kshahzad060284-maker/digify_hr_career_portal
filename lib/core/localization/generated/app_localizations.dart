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

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authSignInTitle;

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

  /// No description provided for @authSource.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get authSource;

  /// No description provided for @authSourceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., CAREER_SITE'**
  String get authSourceHint;

  /// No description provided for @authNoticePeriod.
  ///
  /// In en, this message translates to:
  /// **'Notice Period (Days)'**
  String get authNoticePeriod;

  /// No description provided for @authNoticePeriodHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 30'**
  String get authNoticePeriodHint;

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

  /// No description provided for @authCreateAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful. Please sign in to continue.'**
  String get authCreateAccountSuccess;

  /// No description provided for @authLoggedInLabel.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get authLoggedInLabel;

  /// No description provided for @authSignInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully.'**
  String get authSignInSuccess;

  /// No description provided for @authWelcomeBackUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String authWelcomeBackUser(String name);

  /// No description provided for @authLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get authLogout;

  /// No description provided for @authLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get authLogoutConfirmTitle;

  /// No description provided for @authLogoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get authLogoutConfirmMessage;

  /// No description provided for @authLogoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have been logged out.'**
  String get authLogoutSuccess;

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

  /// No description provided for @dashboardHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'We\'re hiring'**
  String get dashboardHeroBadge;

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

  /// No description provided for @dashboardFilterAllDepartments.
  ///
  /// In en, this message translates to:
  /// **'All Departments'**
  String get dashboardFilterAllDepartments;

  /// No description provided for @dashboardFilterAllEmploymentTypes.
  ///
  /// In en, this message translates to:
  /// **'All Types'**
  String get dashboardFilterAllEmploymentTypes;

  /// No description provided for @dashboardFilterLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get dashboardFilterLocationLabel;

  /// No description provided for @dashboardFilterDepartmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get dashboardFilterDepartmentLabel;

  /// No description provided for @dashboardFilterEmploymentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Job type'**
  String get dashboardFilterEmploymentTypeLabel;

  /// No description provided for @dashboardFilterClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get dashboardFilterClearAll;

  /// No description provided for @dashboardOpenRolesHeading.
  ///
  /// In en, this message translates to:
  /// **'Open roles'**
  String get dashboardOpenRolesHeading;

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

  /// No description provided for @dashboardJobApplicationStatusApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get dashboardJobApplicationStatusApplied;

  /// No description provided for @dashboardJobApplicationStatusNotApplied.
  ///
  /// In en, this message translates to:
  /// **'Not Applied'**
  String get dashboardJobApplicationStatusNotApplied;

  /// No description provided for @dashboardJobViewDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get dashboardJobViewDetails;

  /// No description provided for @dashboardJobCopyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get dashboardJobCopyLink;

  /// No description provided for @dashboardJobLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Job link copied to clipboard'**
  String get dashboardJobLinkCopied;

  /// No description provided for @dashboardEmptyJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'No matching roles'**
  String get dashboardEmptyJobsTitle;

  /// No description provided for @dashboardNoJobsFound.
  ///
  /// In en, this message translates to:
  /// **'No positions match your search or filters. Try adjusting your filters or search terms.'**
  String get dashboardNoJobsFound;

  /// No description provided for @dashboardHeaderMyOffers.
  ///
  /// In en, this message translates to:
  /// **'My Offers'**
  String get dashboardHeaderMyOffers;

  /// No description provided for @dashboardHeaderMyApplications.
  ///
  /// In en, this message translates to:
  /// **'My Applications'**
  String get dashboardHeaderMyApplications;

  /// No description provided for @candidateOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'My Offers'**
  String get candidateOffersTitle;

  /// No description provided for @candidateOffersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View job offers sent to you by companies.'**
  String get candidateOffersSubtitle;

  /// No description provided for @candidateOffersEmpty.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any offers yet. When a company sends you an offer, it will appear here.'**
  String get candidateOffersEmpty;

  /// No description provided for @candidateOffersLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load your offers. Please try again.'**
  String get candidateOffersLoadFailed;

  /// No description provided for @candidateOffersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 offer} other{{count} offers}}'**
  String candidateOffersCount(int count);

  /// No description provided for @candidateOfferStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get candidateOfferStatusPending;

  /// No description provided for @candidateOfferStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get candidateOfferStatusAccepted;

  /// No description provided for @candidateOfferStatusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get candidateOfferStatusDeclined;

  /// No description provided for @candidateOfferStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get candidateOfferStatusExpired;

  /// No description provided for @candidateOfferSentOn.
  ///
  /// In en, this message translates to:
  /// **'Sent {date}'**
  String candidateOfferSentOn(String date);

  /// No description provided for @candidateOfferExpiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires {date}'**
  String candidateOfferExpiresOn(String date);

  /// No description provided for @candidateOfferView.
  ///
  /// In en, this message translates to:
  /// **'View Offer'**
  String get candidateOfferView;

  /// No description provided for @candidateOfferAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get candidateOfferAccept;

  /// No description provided for @candidateOfferDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get candidateOfferDecline;

  /// No description provided for @candidateOfferAcceptTitle.
  ///
  /// In en, this message translates to:
  /// **'Accept Offer'**
  String get candidateOfferAcceptTitle;

  /// No description provided for @candidateOfferAcceptMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to accept this job offer?'**
  String get candidateOfferAcceptMessage;

  /// No description provided for @candidateOfferDeclineTitle.
  ///
  /// In en, this message translates to:
  /// **'Decline Offer'**
  String get candidateOfferDeclineTitle;

  /// No description provided for @candidateOfferDeclineMessage.
  ///
  /// In en, this message translates to:
  /// **'Please provide a reason for declining this offer.'**
  String get candidateOfferDeclineMessage;

  /// No description provided for @candidateOfferDeclineCommentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Decline reason'**
  String get candidateOfferDeclineCommentsLabel;

  /// No description provided for @candidateOfferDeclineCommentsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a reason for declining the offer.'**
  String get candidateOfferDeclineCommentsRequired;

  /// No description provided for @candidateOfferAcceptSuccess.
  ///
  /// In en, this message translates to:
  /// **'Offer accepted successfully.'**
  String get candidateOfferAcceptSuccess;

  /// No description provided for @candidateOfferDeclineSuccess.
  ///
  /// In en, this message translates to:
  /// **'Offer declined successfully.'**
  String get candidateOfferDeclineSuccess;

  /// No description provided for @candidateOfferAcceptFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not accept the offer. Please try again.'**
  String get candidateOfferAcceptFailed;

  /// No description provided for @candidateOfferDeclineFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not decline the offer. Please try again.'**
  String get candidateOfferDeclineFailed;

  /// No description provided for @candidateApplicationsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Applications'**
  String get candidateApplicationsTitle;

  /// No description provided for @candidateApplicationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track the jobs you have applied for.'**
  String get candidateApplicationsSubtitle;

  /// No description provided for @candidateApplicationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t applied to any jobs yet. When you apply, your applications will appear here.'**
  String get candidateApplicationsEmpty;

  /// No description provided for @candidateApplicationsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load your applications. Please try again.'**
  String get candidateApplicationsLoadFailed;

  /// No description provided for @candidateApplicationsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 application} other{{count} applications}}'**
  String candidateApplicationsCount(int count);

  /// No description provided for @candidateApplicationAppliedOn.
  ///
  /// In en, this message translates to:
  /// **'Applied {date}'**
  String candidateApplicationAppliedOn(String date);

  /// No description provided for @candidateApplicationViewJob.
  ///
  /// In en, this message translates to:
  /// **'View Job'**
  String get candidateApplicationViewJob;

  /// No description provided for @dashboardJobsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load job postings. Please try again.'**
  String get dashboardJobsLoadFailed;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @paginationShowingRange.
  ///
  /// In en, this message translates to:
  /// **'Showing {start} - {end} of {total} items'**
  String paginationShowingRange(int start, int end, int total);

  /// No description provided for @paginationPageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String paginationPageOf(int current, int total);

  /// No description provided for @dashboardJobDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Job #{jobId}'**
  String dashboardJobDetailTitle(String jobId);

  /// No description provided for @dashboardJobDetailAboutRole.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get dashboardJobDetailAboutRole;

  /// No description provided for @dashboardJobDetailResponsibilities.
  ///
  /// In en, this message translates to:
  /// **'Key Responsibilities'**
  String get dashboardJobDetailResponsibilities;

  /// No description provided for @dashboardJobDetailQualifications.
  ///
  /// In en, this message translates to:
  /// **'Qualifications'**
  String get dashboardJobDetailQualifications;

  /// No description provided for @dashboardJobDetailTags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get dashboardJobDetailTags;

  /// No description provided for @dashboardJobDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'This job could not be found.'**
  String get dashboardJobDetailNotFound;

  /// No description provided for @dashboardJobDetailLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load job details. Please try again.'**
  String get dashboardJobDetailLoadFailed;

  /// No description provided for @dashboardJobDetailLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading job details...'**
  String get dashboardJobDetailLoading;

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

  /// No description provided for @dashboardJobDetailApply.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get dashboardJobDetailApply;

  /// No description provided for @dashboardJobDetailApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get dashboardJobDetailApplied;

  /// No description provided for @dashboardJobDetailAlreadyApplied.
  ///
  /// In en, this message translates to:
  /// **'You have already applied for this role'**
  String get dashboardJobDetailAlreadyApplied;

  /// No description provided for @dashboardJobDetailCopyEmail.
  ///
  /// In en, this message translates to:
  /// **'Copy email'**
  String get dashboardJobDetailCopyEmail;

  /// No description provided for @dashboardJobDetailEmailCopied.
  ///
  /// In en, this message translates to:
  /// **'Email copied to clipboard'**
  String get dashboardJobDetailEmailCopied;

  /// No description provided for @dashboardJobDetailReadyToApply.
  ///
  /// In en, this message translates to:
  /// **'Interested in this role?'**
  String get dashboardJobDetailReadyToApply;

  /// No description provided for @dashboardJobDetailReadyToApplyBody.
  ///
  /// In en, this message translates to:
  /// **'Submit your application and our team will get back to you.'**
  String get dashboardJobDetailReadyToApplyBody;

  /// No description provided for @dashboardJobApplyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply for Job'**
  String get dashboardJobApplyDialogTitle;

  /// No description provided for @dashboardJobApplyDialogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{jobTitle}'**
  String dashboardJobApplyDialogSubtitle(String jobTitle);

  /// No description provided for @dashboardJobApplyResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get dashboardJobApplyResume;

  /// No description provided for @dashboardJobApplyResumeHint.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF, DOC, or DOCX'**
  String get dashboardJobApplyResumeHint;

  /// No description provided for @dashboardJobApplyChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get dashboardJobApplyChooseFile;

  /// No description provided for @dashboardJobApplySourceRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a source'**
  String get dashboardJobApplySourceRequired;

  /// No description provided for @dashboardJobApplyResumeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please upload your resume'**
  String get dashboardJobApplyResumeRequired;

  /// No description provided for @dashboardJobApplySubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit application'**
  String get dashboardJobApplySubmit;

  /// No description provided for @dashboardJobApplySuccess.
  ///
  /// In en, this message translates to:
  /// **'Your application has been submitted.'**
  String get dashboardJobApplySuccess;

  /// No description provided for @dashboardJobApplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not submit your application. Please try again.'**
  String get dashboardJobApplyFailed;

  /// No description provided for @dashboardJobApplySessionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again to apply for this job.'**
  String get dashboardJobApplySessionRequired;

  /// No description provided for @dashboardJobApplyResumeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Could not read the selected resume file.'**
  String get dashboardJobApplyResumeInvalid;

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
  /// **'Find your next opportunity and grow with a team that invests in you.'**
  String get footerTagline;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Career Portal. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get footerPrivacy;

  /// No description provided for @footerTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get footerTerms;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get footerContact;

  /// No description provided for @footerCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get footerCompanyTitle;

  /// No description provided for @footerCompanyAboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get footerCompanyAboutUs;

  /// No description provided for @footerCompanyOurTeam.
  ///
  /// In en, this message translates to:
  /// **'Our Team'**
  String get footerCompanyOurTeam;

  /// No description provided for @footerCompanyPartners.
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get footerCompanyPartners;

  /// No description provided for @footerCompanyForCandidates.
  ///
  /// In en, this message translates to:
  /// **'For Candidates'**
  String get footerCompanyForCandidates;

  /// No description provided for @footerCompanyForEmployers.
  ///
  /// In en, this message translates to:
  /// **'For Employers'**
  String get footerCompanyForEmployers;

  /// No description provided for @footerJobCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Categories'**
  String get footerJobCategoriesTitle;

  /// No description provided for @footerCategoryTelecommunications.
  ///
  /// In en, this message translates to:
  /// **'Telecommunications'**
  String get footerCategoryTelecommunications;

  /// No description provided for @footerCategoryHotelsTourism.
  ///
  /// In en, this message translates to:
  /// **'Hotels & Tourism'**
  String get footerCategoryHotelsTourism;

  /// No description provided for @footerCategoryConstruction.
  ///
  /// In en, this message translates to:
  /// **'Construction'**
  String get footerCategoryConstruction;

  /// No description provided for @footerCategoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get footerCategoryEducation;

  /// No description provided for @footerCategoryFinancialServices.
  ///
  /// In en, this message translates to:
  /// **'Financial Services'**
  String get footerCategoryFinancialServices;

  /// No description provided for @footerNewsletterTitle.
  ///
  /// In en, this message translates to:
  /// **'Newsletter'**
  String get footerNewsletterTitle;

  /// No description provided for @footerNewsletterDescription.
  ///
  /// In en, this message translates to:
  /// **'Get the latest open roles and career tips in your inbox.'**
  String get footerNewsletterDescription;

  /// No description provided for @footerNewsletterEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get footerNewsletterEmailHint;

  /// No description provided for @footerNewsletterSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe now'**
  String get footerNewsletterSubscribe;

  /// No description provided for @footerNewsletterEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get footerNewsletterEmailRequired;

  /// No description provided for @footerNewsletterSuccess.
  ///
  /// In en, this message translates to:
  /// **'Thanks for subscribing. We\'ll keep you updated.'**
  String get footerNewsletterSuccess;

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
