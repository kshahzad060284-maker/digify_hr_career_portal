enum EmployerAssignmentType {
  enterpriseLevel('ENTERPRISE_LEVEL'),
  companyLevel('COMPANY_LEVEL');

  const EmployerAssignmentType(this.apiValue);

  final String apiValue;

  static EmployerAssignmentType? tryParse(String? value) {
    final normalized = value?.trim().toUpperCase();
    if (normalized == null || normalized.isEmpty) return null;
    for (final type in EmployerAssignmentType.values) {
      if (type.apiValue == normalized) return type;
    }
    return null;
  }
}
