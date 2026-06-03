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
  String dashboardJobDetailTitle(String jobId) {
    return 'الوظيفة رقم $jobId';
  }

  @override
  String get dashboardJobDetailAboutRole => 'نبذة عن الدور';

  @override
  String get dashboardJobDetailResponsibilities => 'المسؤوليات';

  @override
  String get dashboardJobDetailQualifications => 'المؤهلات';

  @override
  String get dashboardJobDetailNotFound => 'تعذر العثور على هذه الوظيفة.';

  @override
  String get dashboardJobDetailBack => 'العودة إلى جميع الوظائف';

  @override
  String get dashboardJobDetailSignInToApply => 'سجّل الدخول للتقديم';

  @override
  String get dashboardJobDetailSidebarTitle => 'تفاصيل الوظيفة';

  @override
  String get dashboardJobDetailSalaryRange => 'نطاق الراتب';

  @override
  String get dashboardJobDetailOpeningsLabel => 'الشواغر';

  @override
  String dashboardJobDetailPositionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count وظائف',
      one: 'وظيفة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get dashboardJobDetailStartDate => 'تاريخ البدء';

  @override
  String get dashboardJobDetailLevel => 'المستوى';

  @override
  String get dashboardJobDetailQuestionsTitle => 'أسئلة؟';

  @override
  String get dashboardJobDetailQuestionsBody =>
      'فريق التوظيف لدينا هنا للمساعدة. لا تتردد في التواصل معنا بخصوص أي أسئلة حول هذا الدور.';

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
