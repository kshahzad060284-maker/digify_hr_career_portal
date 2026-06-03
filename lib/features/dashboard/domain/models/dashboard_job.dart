class DashboardJob {
  const DashboardJob({
    required this.id,
    required this.title,
    required this.department,
    required this.location,
    required this.employmentType,
    required this.description,
    required this.responsibilities,
    required this.qualifications,
    required this.salaryRange,
    required this.startDate,
    required this.level,
    required this.contactEmail,
    required this.openingsCount,
    this.isUrgent = false,
  });

  final String id;
  final String title;
  final String department;
  final String location;
  final String employmentType;
  final String description;
  final List<String> responsibilities;
  final List<String> qualifications;
  final String salaryRange;
  final String startDate;
  final String level;
  final String contactEmail;
  final int openingsCount;
  final bool isUrgent;
}
