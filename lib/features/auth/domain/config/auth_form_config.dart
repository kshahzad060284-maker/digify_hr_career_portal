abstract final class AuthFormConfig {
  AuthFormConfig._();

  static final DateTime formDateFirst = DateTime(1950);
  static final DateTime formDateLast = DateTime(
    DateTime.now().year + 5,
    12,
    31,
  );

  static const List<String> educationGradeOptions = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'Pass',
    'Distinction',
    'First Class',
    'Second Class',
    'Other',
  ];
}
