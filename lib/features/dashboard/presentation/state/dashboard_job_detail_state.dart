import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';

class DashboardJobDetailState {
  const DashboardJobDetailState({required this.postingGuid, required this.job});

  final String postingGuid;
  final DashboardJob job;
}
