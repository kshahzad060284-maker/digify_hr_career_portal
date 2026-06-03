import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:intl/intl.dart';

class RegisterWorkExperienceEntry {
  const RegisterWorkExperienceEntry({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.startDate,
    required this.isCurrentJob,
    this.endDate,
    this.description = '',
  });

  final String id;
  final String companyName;
  final String jobTitle;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentJob;
  final String description;

  static final _dateFormat = DateFormat('MMM yyyy');

  String get displayTitle => '$jobTitle · $companyName';

  String displaySubtitle(AppLocalizations l10n) {
    final start = _dateFormat.format(startDate);
    final end = isCurrentJob
        ? l10n.authPresent
        : (endDate != null ? _dateFormat.format(endDate!) : '');
    return '$location · $start – $end';
  }
}
