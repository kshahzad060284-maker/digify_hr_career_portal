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
  String get authWelcomeBack => 'Welcome Back';

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
  String get dashboardJobSearchPlaceholder =>
      'Search for jobs by title, department, or keyword...';

  @override
  String get dashboardFilterAllLocations => 'All Locations';

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
  String get dashboardNoJobsFound =>
      'No positions match your search or filters.';

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
  String get dashboardJobDetailBack => 'Back to all jobs';

  @override
  String get dashboardJobDetailSignInToApply => 'Sign in to Apply';

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
      'A clean header-content-footer layout for the web.';

  @override
  String get footerCopyright => '© 2026 Career Portal. All rights reserved.';

  @override
  String get footerPrivacy => 'Privacy';

  @override
  String get footerTerms => 'Terms';

  @override
  String get footerContact => 'Contact';

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
}
