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
