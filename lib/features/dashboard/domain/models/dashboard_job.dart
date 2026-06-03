class DashboardJob {
  const DashboardJob({
    required this.id,
    required this.title,
    required this.department,
    required this.location,
    required this.employmentType,
    required this.description,
    required this.openingsCount,
    this.isUrgent = false,
  });

  final String id;
  final String title;
  final String department;
  final String location;
  final String employmentType;
  final String description;
  final int openingsCount;
  final bool isUrgent;
}
