import 'package:intl/intl.dart';

class RegisterEducationEntry {
  const RegisterEducationEntry({
    required this.id,
    required this.degreeName,
    required this.institutionName,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    required this.grade,
    this.description = '',
  });

  final String id;
  final String degreeName;
  final String institutionName;
  final String fieldOfStudy;
  final DateTime startDate;
  final DateTime endDate;
  final String grade;
  final String description;

  static final _dateFormat = DateFormat('MMM yyyy');

  String get displayTitle => degreeName;

  String get displaySubtitle {
    final range =
        '${_dateFormat.format(startDate)} – ${_dateFormat.format(endDate)}';
    return '$institutionName · $fieldOfStudy · $range';
  }
}
