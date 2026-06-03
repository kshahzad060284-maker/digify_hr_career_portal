// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'بوابة الوظائف';

  @override
  String get appTagline => 'اعثر على فرصتك القادمة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get register => 'التسجيل';

  @override
  String get welcome => 'مرحبا';

  @override
  String get browseJobs => 'تصفح الوظائف';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navJobs => 'الوظائف';

  @override
  String get navCompanies => 'الشركات';

  @override
  String get navAbout => 'حول';

  @override
  String get dashboardWelcomeTitle => 'مرحباً بك في لوحة التحكم';

  @override
  String get dashboardWelcomeSubtitle =>
      'نظرة عامة على نشاط بوابة الوظائف والوحدات.';

  @override
  String get dashboardJoinTeamTitle => 'انضم إلى فريقنا';

  @override
  String get dashboardJoinTeamSubtitle =>
      'اكتشف فرصتك المهنية القادمة وكن جزءاً من شيء رائع';

  @override
  String get dashboardJobSearchPlaceholder =>
      'ابحث عن الوظائف حسب المسمى أو القسم أو الكلمة المفتاحية...';

  @override
  String get dashboardFilterAllLocations => 'جميع المواقع';

  @override
  String dashboardPositionsAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count وظائف متاحة',
      one: 'وظيفة واحدة متاحة',
    );
    return '$_temp0';
  }

  @override
  String dashboardJobOpenings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شواغر',
      one: 'شاغر واحد',
    );
    return '$_temp0';
  }

  @override
  String get dashboardJobUrgentHiring => 'توظيف عاجل';

  @override
  String get dashboardNoJobsFound =>
      'لا توجد وظائف تطابق بحثك أو عوامل التصفية.';

  @override
  String get footerTagline => 'تخطيط واضح: رأس ومحتوى وتذييل للويب.';

  @override
  String get footerCopyright => '© 2026 بوابة الوظائف. جميع الحقوق محفوظة.';

  @override
  String get footerPrivacy => 'الخصوصية';

  @override
  String get footerTerms => 'الشروط';

  @override
  String get footerContact => 'اتصل بنا';

  @override
  String get timePickerTitle => 'تعيين الوقت';

  @override
  String get timePickerSubtitle => 'اضغط على الرقم للكتابة';

  @override
  String get timePickerHourLabel => 'الساعة';

  @override
  String get timePickerMinuteLabel => 'الدقيقة';

  @override
  String get timePickerPeriodLabel => 'الفترة';

  @override
  String get timePickerCancel => 'إلغاء';

  @override
  String get timePickerUpdate => 'تحديث الوقت';

  @override
  String get timePickerSelectHint => 'اختر الوقت';

  @override
  String get timePickerAm => 'ص';

  @override
  String get timePickerPm => 'م';
}
